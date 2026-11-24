from rest_framework import  permissions, viewsets, status, views
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from ..fields import EncryptionService
from django.http import HttpResponse, JsonResponse
from rest_framework import generics
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from ..permissoes import IsAdministrador, usuarios_visiveis
 

def get_admin_details(request, admin_id):
    admin = get_object_or_404(CustomUser, id = admin_id)
    return JsonResponse({
        'id': admin.id,
        'username': admin.username
    })
 
class AdminUserCreateView(generics.ListCreateAPIView):
    """
    POST /admin/register/ — o administrador cadastra um PESQUISADOR. A conta fica vinculada a quem a criou
    (criado_por) e aparece na aba "Usuários" dele. Administradores não podem criar outros administradores
    nem alterar o perfil de contas existentes: o perfil Administrador só é escolhido no cadastro público,
    pelo próprio usuário. Exclusivo de administradores.
    """
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAdministrador]

    def get_queryset(self):
        return usuarios_visiveis(self.request.user)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        perfil = data.get('acessLevel') or 'Pesquisador'
        if perfil != 'Pesquisador':
            return Response(
                {"acessLevel": ["Administradores só podem cadastrar pesquisadores. O perfil Administrador é "
                                "escolhido pelo próprio usuário no cadastro do aplicativo."]},
                status=status.HTTP_403_FORBIDDEN
            )

        email = EncryptionService.normalizar_email(data.get('email'))
        if not email:
            return Response({"email": ["Este campo é obrigatório."]}, status=status.HTTP_400_BAD_REQUEST)

        # O e-mail é criptografado no banco (Fernet, não determinístico): a busca é pelo blind index
        if CustomUser.objects.filter(email_hash=EncryptionService().get_email_index(email)).exists():
            return Response({"email": ["Este e-mail já está cadastrado."]}, status=status.HTTP_400_BAD_REQUEST)

        data['email'] = email
        data['acessLevel'] = 'Pesquisador'
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save(criado_por=request.user)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
