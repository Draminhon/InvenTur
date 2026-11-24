from rest_framework import  permissions, viewsets, status, views
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from ..fields import EncryptionService
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


# O que um administrador pode alterar na conta de OUTRA pessoa: só aprovar/bloquear e desativar.
# Nome, e-mail, senha e perfil são da própria pessoa (senão o admin poderia tomar a conta de quem entrou na pesquisa).
CAMPOS_DO_ADMIN_EM_OUTRAS_CONTAS = ('status', 'is_active')

# Na própria conta, trocar e-mail ou senha exige a senha atual (protege contra um token/aparelho roubado)
CAMPOS_QUE_EXIGEM_SENHA_ATUAL = ('email', 'password')


def _sem_campos_restritos(dados):
    # Dicionário simples, sem cópia profunda: QueryDict.copy() copiaria também os arquivos enviados, e uma foto
    # grande (gravada pelo Django em arquivo temporário) não pode ser copiada — o upload dava erro 500
    return {campo: valor for campo, valor in dados.items() if campo not in CAMPOS_RESTRITOS_A_ADMIN}


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
        alvo = self.get_object()
        if alvo.id != request.user.id:
            # Administrador alterando a conta de outra pessoa (o get_queryset já limita a quem ele pode ver)
            dados = {campo: request.data[campo] for campo in CAMPOS_DO_ADMIN_EM_OUTRAS_CONTAS if campo in request.data}
            if not dados:
                return Response({'detail': 'O administrador só pode alterar a situação ou desativar a conta de '
                                           'outra pessoa. Os dados pessoais são alterados pela própria pessoa.'},
                                status=status.HTTP_403_FORBIDDEN)
            request._full_data = dados
            kwargs['partial'] = True
            return super().update(request, *args, **kwargs)

        # A própria conta: nunca altera perfil, situação ou permissões
        dados = _sem_campos_restritos(request.data)
        if self._muda_email_ou_senha(alvo, dados) and not alvo.check_password(str(dados.get('senha_atual') or '')):
            return Response({'senha_atual': ['Informe sua senha atual para alterar o e-mail ou a senha.']},
                            status=status.HTTP_400_BAD_REQUEST)
        dados.pop('senha_atual', None)
        request._full_data = dados
        return super().update(request, *args, **kwargs)

    @staticmethod
    def _muda_email_ou_senha(user, dados):
        senha = dados.get('password')
        if senha not in (None, '') and str(senha).strip():
            return True
        email = dados.get('email')
        return email not in (None, '') and EncryptionService.normalizar_email(email) != user.email

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
        user = self.request.user

        return Pesquisa.objects.filter(usuario=user, is_active=True)