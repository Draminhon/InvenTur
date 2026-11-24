from rest_framework import  permissions, viewsets, status, views
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.throttling import UserRateThrottle
from ..permissoes import IsAdministrador, eh_administrador, pesquisas_visiveis
from ..models import TAMANHO_CODIGO_PESQUISA, normalizar_codigo_pesquisa


class VincularPesquisaThrottle(UserRateThrottle):
    scope = 'vincular_pesquisa'
    rate = '10/min'


class PesquisaViewSet(viewsets.ModelViewSet):

    queryset = Pesquisa.objects.filter(is_active=True)
    serializer_class = PesquisaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        # Administrador: só as pesquisas que criou; pesquisador: só as da sua equipe (ver permissoes.py)
        return pesquisas_visiveis(self.request.user)

    def get_permissions(self):
        # Criar e excluir pesquisas é exclusivo de administradores
        if self.action in ('create', 'destroy'):
            return [IsAdministrador()]
        return super().get_permissions()

    def perform_create(self, serializer):
        # O dono é sempre quem cria (o valor de "admin" enviado pelo app é ignorado)
        serializer.save(admin=self.request.user)

    @action(detail=False, methods=['post'], url_path='vincular', throttle_classes=[VincularPesquisaThrottle])
    def vincular(self, request):
        """
        POST /pesquisa/vincular/  {"codigo": "K7MQ2XRP"}
        O pesquisador entra na equipe da pesquisa usando o código compartilhado pelo administrador.
        Limitado a 10 tentativas por minuto por usuário, para impedir que códigos sejam descobertos por tentativa.
        """
        user = request.user
        if eh_administrador(user):
            return Response({'detail': 'Administradores não se vinculam a pesquisas por código.'},
                            status=status.HTTP_403_FORBIDDEN)
        if getattr(user, 'status', 'Ativo') != 'Ativo':
            return Response({'detail': 'Seu cadastro ainda não foi aprovado. Aguarde a liberação de um administrador.'},
                            status=status.HTTP_403_FORBIDDEN)

        codigo = normalizar_codigo_pesquisa(request.data.get('codigo'))
        if len(codigo) != TAMANHO_CODIGO_PESQUISA:
            return Response({'detail': f'O código deve ter {TAMANHO_CODIGO_PESQUISA} caracteres.'},
                            status=status.HTTP_400_BAD_REQUEST)

        pesquisa = Pesquisa.objects.filter(codigo=codigo, is_active=True).first()
        if pesquisa is None:
            return Response({'detail': 'Nenhuma pesquisa encontrada com esse código. Confira com o administrador.'},
                            status=status.HTTP_404_NOT_FOUND)

        dados = {'id': pesquisa.id, 'municipio': pesquisa.municipio, 'estado': pesquisa.estado,
                 'status': pesquisa.status}
        if pesquisa.usuario.filter(id=user.id).exists():
            return Response({'detail': f'Você já faz parte da pesquisa de {pesquisa.municipio} - {pesquisa.estado}.',
                             'ja_vinculado': True, 'pesquisa': dados}, status=status.HTTP_200_OK)
        if pesquisa.status == 'Concluído':
            return Response({'detail': 'Esta pesquisa já foi concluída e não aceita novos pesquisadores.'},
                            status=status.HTTP_400_BAD_REQUEST)

        pesquisa.usuario.add(user)
        user.pesquisas.add(pesquisa)
        return Response({'detail': f'Você agora faz parte da pesquisa de {pesquisa.municipio} - {pesquisa.estado}.',
                         'ja_vinculado': False, 'pesquisa': dados}, status=status.HTTP_201_CREATED)

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

    @action(detail=True, methods=['patch'], url_path='remover-pesquisador')
    def remover_pesquisador(self, request, pk=None):
        pesquisa = self.get_object()
        user_id = request.data.get('user_id')
        print(f"Tentando remover user_id: {user_id} da pesquisa {pesquisa.id}")
        if user_id is None:
            return Response({"detail": "user_id é obrigatório"}, status=status.HTTP_400_BAD_REQUEST)
        user = get_object_or_404(CustomUser, id=user_id)
        if not pesquisa.usuario.filter(id=user.id).exists():
            return Response({"detail": "usuário não está associado a essa pesquisa"}, status=status.HTTP_400_BAD_REQUEST)
        pesquisa.usuario.remove(user)
        pesquisa.save()
        return Response({"detail": "Pesquisador removido com sucesso"}, status=status.HTTP_200_OK)


class BaseViewSet(viewsets.ModelViewSet):
    queryset = Base.objects.all()
    serializer_class = DynamicBaseSerializer

    def get_queryset(self):
        return Base.objects.filter(pesquisa__in=pesquisas_visiveis(self.request.user))

    def update(self, request, *args, **kwargs):
        instance = self.get_object()  # respeita o escopo de pesquisas do usuário (404 fora dele)
        serializer = self.get_serializer(instance, data=request.data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
         
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)