from rest_framework import generics, permissions
from .serializers import UserSerializer
from .models import *
from .serializers import *
from rest_framework import status
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login
import json
from django.http import HttpResponse, JsonResponse
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import IsAuthenticated
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from rest_framework.exceptions import ValidationError
class UsuarioCreateView(generics.ListCreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return HttpResponse(serializer.data, status = status.HTTP_201_CREATED, headers=headers)
    
class UsuarioListView(generics.ListAPIView):
    queryset = CustomUser.objects.filter(is_active=True)
    serializer_class = UserSerializer

class AlterUserAPIView(generics.UpdateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)
    
class AlterPesquisaAPIView(generics.UpdateAPIView):
    queryset = Pesquisa.objects.all()
    serializer_class = PesquisaSerializer

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)


class PesquisaCreateView(generics.ListCreateAPIView):
    queryset = Pesquisa.objects.filter(is_active=True)
    serializer_class = PesquisaSerializer

    def perform_create(self, serializer):
        # Obtém os IDs dos usuários enviados na requisição
        usuarios_ids = self.request.data.get('usuario', [])

        pesquisa = serializer.save()

        return pesquisa

class PesquisaUsuarioListView(generics.ListAPIView):

    serializer_class = PesquisaSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user

        return Pesquisa.objects.filter(usuario=user, is_active=True)
    



def get_admin_details(request, admin_id):
    admin = get_object_or_404(CustomUser, id = admin_id)
    return JsonResponse({
        'id': admin.id,
        'username': admin.username
    })

class PesquisaStatusUpdateAPIView(generics.UpdateAPIView):
    queryset = Pesquisa.objects.all()
    serializer_class = PesquisaSerializer

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)

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

           return HttpResponse(
               {"message": "Usuário atualizado com sucesso!", "id": user.id},
                status=status.HTTP_200_OK
            )
        else:
            data['acessLevel'] = 'Administrador'

            serializer = self.get_serializer(data=data)
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            headers = self.get_success_headers(serializer.data)
            return HttpResponse(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

@csrf_exempt # Apenas para testes locais. Em produção, use o CSRF adequadamente
def UsuarioLoginView(request):
    if request.method == "POST":
        if request.content_type == "application/json":
            try:
                data = json.loads(request.body)
                CPF = data.get("CPF")
                password = data.get("password")

            except json.JSONDecodeError:
                return HttpResponse("Invalid JSON", status = status.HTTP_400_BAD_REQUEST)
        else:
            CPF = request.POST.get("CPF")
            password = request.POST.get("password")

   

        user = authenticate(request, CPF = CPF, password = password)
        if user is not None:
         
            refresh = RefreshToken.for_user(user)
            print("Logado com sucesso")
            print(str(refresh.access_token))

            return JsonResponse({
                'refresh': str(refresh),
                'acess': str(refresh.access_token),
                'user':{
                    'id': user.id,
                    'CPF': user.CPF,
                    'name': user.username,
                    'email': user.email,
                    'acess_level': user.acessLevel,
                    'status': user.status
                }
            }, status = 200)
    
        else:
         
            print("Nao logado")
            return HttpResponse("Invalid credentials", status = 400)
        
class RodoviaListCreateAPIView(generics.ListCreateAPIView):
    queryset = Rodovia.objects.all()
    serializer_class = RodoviaSerializer

class RodoviaListView(generics.ListAPIView):
    serializer_class = RodoviaSerializer

    def get_queryset(self):
        pesquisa_id = self.request.query_params.get('pesquisa_id')

        if not pesquisa_id:
            raise ValidationError({"detail": "O parâmetro  'pesquisa_id' é obrigatório."})
        try:
            return Rodovia.objects.filter(pesquisa__id=pesquisa_id)
        except Rodovia.DoesNotExist:
            return Rodovia.objects.none()
        
class RodoviaUpdateAPIView(generics.UpdateAPIView):
    queryset = Rodovia.objects.all()
    serializer_class = RodoviaSerializer

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)
    
class StatusUpdateAPIView(generics.UpdateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)
    
# class DeleUserAPIView(generics.DestroyAPIView):
#     queryset = CustomUser.objects.all()
#     serializer_class = UserSerializer
