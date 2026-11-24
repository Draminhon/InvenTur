from rest_framework import  permissions, viewsets, status, views
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse
from rest_framework import generics
from django.db.models import Q
from rest_framework.decorators import action
from ..permissoes import IsAdministrador, eh_administrador, exigir_pesquisa_visivel, usuarios_visiveis
from ..termos import TERMOS_VERSAO, registrar_aceite_termos
from ..retencao import excluir_conta, pesquisas_ativas_do_admin

 
# Perfis que podem ser escolhidos no cadastro público (o status e as demais permissões nunca vêm do cliente)
PERFIS_DE_CADASTRO = ('Pesquisador', 'Administrador')

# Campos que só um administrador pode definir (o próprio usuário não pode se promover nem se aprovar)
CAMPOS_RESTRITOS_A_ADMIN = ('acessLevel', 'status', 'is_active', 'is_staff', 'is_superuser', 'pesquisas')


def _sem_campos_restritos(dados):
    dados = dados.copy()
    for campo in CAMPOS_RESTRITOS_A_ADMIN:
        dados.pop(campo, None)
    return dados


class UserViewSet(viewsets.ModelViewSet):
    """
    - cadastro público (POST): o próprio usuário escolhe o perfil (Pesquisador ou Administrador);
      exige o aceite dos Termos de Uso. É o ÚNICO meio de criar um administrador;
    - pesquisador: só vê e edita a própria conta, sem alterar nível de acesso, status ou ativação;
    - administrador: vê e gerencia os usuários (aba "Usuários"); só ele exclui contas.
    """
    queryset = CustomUser.objects.filter(is_active=True, is_superuser=False)
    serializer_class = UserSerializer

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.AllowAny()]
        if self.action == 'destroy':
            return [IsAdministrador()]
        return [permissions.IsAuthenticated()]

    def get_queryset(self):
        user = self.request.user
        if not eh_administrador(user):
            return super().get_queryset().filter(id=user.id)
        # Administrador: só quem entrou numa pesquisa dele ou foi cadastrado por ele; ?pesquisa_id= filtra
        qs = usuarios_visiveis(user)
        pesquisa_id = self.request.query_params.get('pesquisa_id')
        if pesquisa_id and self.action == 'list':
            pesquisa_id = exigir_pesquisa_visivel(user, pesquisa_id)
            qs = qs.filter(usuario__id=pesquisa_id)
        if self.action != 'list':
            # O próprio administrador não aparece na lista, mas continua podendo ver/editar o seu perfil
            qs = CustomUser.objects.filter(Q(id__in=qs.values('id')) | Q(id=user.id))
        return qs

    def create(self, request, *args, **kwargs):
        perfil = request.data.get('acessLevel') or 'Pesquisador'
        if perfil not in PERFIS_DE_CADASTRO:
            return Response({'acessLevel': ["Perfil inválido. Escolha 'Pesquisador' ou 'Administrador'."]},
                            status=status.HTTP_400_BAD_REQUEST)
        dados = _sem_campos_restritos(request.data)
        if dados.get('aceite_termos') not in (True, 'true', 'True', '1', 1):
            return Response({'aceite_termos': ['É necessário ler e aceitar os Termos de Uso e a Política de Privacidade.']},
                            status=status.HTTP_400_BAD_REQUEST)
        dados['acessLevel'] = perfil
        serializer = self.get_serializer(data=dados)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        registrar_aceite_termos(user)
        return Response(self.get_serializer(user).data, status=status.HTTP_201_CREATED)

    def update(self, request, *args, **kwargs):
        if not eh_administrador(request.user):
            request._full_data = _sem_campos_restritos(request.data)
        return super().update(request, *args, **kwargs)

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)

    @action(detail=False, methods=['post'], url_path='excluir-conta')
    def excluir_conta(self, request):
        """
        POST /user/excluir-conta/ {"senha": "..."} — o próprio usuário exclui a conta (direito de eliminação, LGPD).
        Os dados pessoais são eliminados na hora; fica só o mínimo para comprovar autoria e o aceite dos termos.
        """
        user = request.user
        if not user.check_password(request.data.get('senha') or ''):
            return Response({'senha': ['Senha incorreta.']}, status=status.HTTP_400_BAD_REQUEST)
        pesquisas = pesquisas_ativas_do_admin(user).count()
        if pesquisas:
            return Response({'detail': f'Você ainda é responsável por {pesquisas} pesquisa(s). Exclua-as antes de '
                                       'excluir sua conta, para que não fiquem sem administrador.'},
                            status=status.HTTP_409_CONFLICT)
        excluir_conta(user)
        return Response({'detail': 'Conta excluída. Seus dados pessoais foram eliminados.'})

    @action(detail=False, methods=['post'], url_path='aceitar-termos')
    def aceitar_termos(self, request):
        """POST /user/aceitar-termos/ {"versao": "..."} — registra o aceite da versão vigente dos termos."""
        if str(request.data.get('versao')) != TERMOS_VERSAO:
            return Response({'detail': 'Versão dos termos desatualizada. Atualize o aplicativo.',
                             'versao_atual': TERMOS_VERSAO}, status=status.HTTP_409_CONFLICT)
        registrar_aceite_termos(request.user)
        return Response({'detail': 'Aceite registrado.', 'versao': TERMOS_VERSAO,
                         'aceito_em': request.user.termos_aceitos_em})


class StatusUpdateAPIView(generics.UpdateAPIView):
    """Aprovação/alteração de status de usuários — exclusivo de administradores."""
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAdministrador]

    def get_queryset(self):
        return usuarios_visiveis(self.request.user)

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)


class PesquisaUsuarioAuth(generics.ListAPIView):
    serializer_class = PesquisaSerializer
    permission_classes = [permissions.IsAuthenticated] 
    authentication_classes = [JWTAuthentication]
    def get_queryset(self):
        print(self.request.headers)
        user = self.request.user
        print(f"Usuário autenticado: {user} - {user.is_authenticated}")  # Log no servidor

        return Pesquisa.objects.filter(usuario=user, is_active=True)