from rest_framework import generics
from .serializers import UserSerializer
from .models import CustomUser, Rodovia
from .serializers import RodoviaSerializer
from rest_framework.response import Response
from rest_framework import status
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login
import json
from django.http import HttpResponse

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
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

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

        print(str(CPF) + " n")
        print(password + " s")  

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

 