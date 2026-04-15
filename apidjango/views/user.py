from rest_framework import  permissions, viewsets, status, views
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse
from rest_framework import generics

  
class UserViewSet(viewsets.ModelViewSet):

    queryset = CustomUser.objects.filter(is_active=True, is_superuser=False)
    serializer_class = UserSerializer


    def get_permissions(self):
        if self.action == 'create':
            return [permissions.AllowAny()]
        return [permissions.IsAuthenticated()]


    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class StatusUpdateAPIView(generics.UpdateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

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