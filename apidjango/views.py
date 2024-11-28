from rest_framework import generics, viewsets
from rest_framework.decorators import action
from .serializers import UserSerializer
from .models import *
from .serializers import *
from rest_framework.response import Response
from rest_framework import status
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login
import json
from django.http import HttpResponse
from django.db import transaction

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

class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    @action(detail=True, methods=['post'])
    def adicionar_pesquisa(self, request, pk=None):
        user = self.get_object()
        pesquisa_id = request.data.get('pesquisa_id')
        try:
            pesquisa = Pesquisa.objects.get(id=pesquisa_id)
            user.pesquisas.add(pesquisa)
            return Response({"status": "Pesquisa adicionada ao usuário"})
        except Pesquisa.DoesNotExist:
            return Response({"error": "Pesquisa não encontrada"}, status=400)
        
class PesquisaViewSet(viewsets.ModelViewSet):
    queryset = Pesquisa.objects.all()
    serializer_class = PesquisaSerializer

class AlterUserAPIView(generics.UpdateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)

class PesquisaCreateView(generics.ListCreateAPIView):
    queryset = Pesquisa.objects.all()
    serializer_class = PesquisaSerializer

    def perform_create(self, serializer):
        # Obtém os IDs dos usuários enviados na requisição
        usuarios_ids = self.request.data.get('usuario', [])

        pesquisa = serializer.save()

          
            
        return pesquisa


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
         
            login(request, user)
            print("Logado com sucesso")
            return HttpResponse("login sucessful", status = 200)
    
        else:
         
            print("Nao logado")
            return HttpResponse("Invalid credentials", status = 400)
        
class RodoviaListCreateAPIView(generics.ListCreateAPIView):
    queryset = Rodovia.objects.all()
    serializer_class = RodoviaSerializer

class RodoviaListView(generics.ListAPIView):
    queryset = Rodovia.objects.all()
    serializer_class = RodoviaSerializer

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
