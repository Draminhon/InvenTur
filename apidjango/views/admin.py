from rest_framework import  permissions, viewsets, status, views
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse
from rest_framework import generics
from rest_framework.response import Response
from django.shortcuts import get_object_or_404


def get_admin_details(request, admin_id):
    admin = get_object_or_404(CustomUser, id = admin_id)
    return JsonResponse({
        'id': admin.id,
        'username': admin.username
    })

class AdminUserCreateView(generics.ListCreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        cpf = data.get('CPF')

        user = CustomUser.objects.filter(CPF=cpf).first()

        if user:
           user.acessLevel = 'Administrador'
           user.save()

           return Response(
               {"message": "Usuário atualizado com sucesso!", "id": user.id},
                status=status.HTTP_200_OK
            )
        else:
            data['access_level'] = 'Administrador'

            serializer = self.get_serializer(data=data)
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers) 