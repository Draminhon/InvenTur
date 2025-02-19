from rest_framework import generics, permissions, viewsets
from .serializers import UserSerializer
from .models import *
from .serializers import *
from rest_framework import status
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login
import json
from django.http import HttpResponse, JsonResponse
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import IsAuthenticated, AllowAny
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from rest_framework.exceptions import ValidationError
from django.contrib.auth import logout
from rest_framework.views import APIView
from rest_framework_simplejwt.authentication import JWTAuthentication
import openpyxl
from django.shortcuts import get_object_or_404
from django.db.models import Model


def export_pesquisa_to_excel(request, pesquisa_id):
    try:
        pesquisa = Pesquisa.objects.get(id=pesquisa_id)
        equipamentos = AlimentosEBebidas.objects.filter(pesquisa=pesquisa)  # Ajuste o relacionamento

        # Criando um arquivo Excel
        wb = openpyxl.Workbook()
        ws = wb.active
        ws.title = f"Pesquisa {pesquisa.id}"

        field_names = [field.name for field in equipamentos.model._meta.fields]
        # Criar cabeçalhos da planilha
        ws.append(field_names)  # Ajuste conforme os campos do modelo

        # Adicionar os equipamentos da pesquisa
        for equipamento in equipamentos:
            row = []
            for field in field_names:
                value = getattr(equipamento, field)

                if isinstance(value, Model):
                    value = str(value)
                elif isinstance(value, (list, dict)):
                    value = json.dumps(value, ensure_ascii=False)
                row.append(value)
            ws.append(row)


        # Criar a resposta HTTP com o arquivo Excel
        response = HttpResponse(content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response["Content-Disposition"] = f'attachment; filename="pesquisa_{pesquisa.id}.xlsx"'
        wb.save(response)

        return response

    except Pesquisa.DoesNotExist:
        return HttpResponse("Pesquisa não encontrada", status=404)



class UsuarioCreateView(generics.ListCreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer
    
    permission_classes = [permissions.AllowAny] 


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
        try:
            print("Dados recebidos no servidor:", request.data)
            kwargs['partial'] = True
            return self.update(request, *args, **kwargs)
        except ValidationError as e:
            print("Erro de validação:", e.detail)  # Exibe detalhes da validação
            return Response({"error": e.detail}, status=400)
        except Exception as e:
            print("Erro inesperado:", str(e))
            raise


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
   # authentication_classes = [JWTAuthentication]
    def get_queryset(self):
        print(self.request.headers)
        user = self.request.user
        print(f"Usuário autenticado: {user} - {user.is_authenticated}")  # Log no servidor

        return Pesquisa.objects.filter(usuario=user, is_active=True)
    

class PesquisaPartialUpdateAPIView(generics.UpdateAPIView):
    queryset = Pesquisa.objects.all()
    serializer_class = PesquisaSerializer

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)

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

@csrf_exempt
def UsuarioLoginView(request):
    # Responde a métodos não-POST com erro 405
    if request.method != "POST":
        return JsonResponse(
            {"error": "Método não permitido"}, 
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )

    CPF = None
    password = None

    # Tratamento para JSON
    if request.content_type == "application/json":
        try:
            data = json.loads(request.body)
            CPF = data.get("CPF")
            password = data.get("password")
        except json.JSONDecodeError:
            return JsonResponse(
                {"error": "JSON inválido"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
    # Tratamento para form-data/x-www-form-urlencoded
    else:
        CPF = request.POST.get("CPF")
        password = request.POST.get("password")

    # Validação dos campos
    if not CPF or not password:
        return JsonResponse(
            {"error": "CPF e senha são obrigatórios"}, 
            status=status.HTTP_400_BAD_REQUEST
        )

    # Autenticação
    user = authenticate(request, CPF=CPF, password=password)
    if user is None:
        return JsonResponse(
            {"error": "Credenciais inválidas"}, 
            status=status.HTTP_401_UNAUTHORIZED
        )

    # Geração do token JWT
    try:
        refresh = RefreshToken.for_user(user)
        return JsonResponse({
            "refresh": str(refresh),
            "access": str(refresh.access_token),
            "user": {
                "id": user.id,
                "CPF": user.CPF,
                "name": user.username,
                "email": user.email,
                "access_level": user.acessLevel,
                "status": user.status
            }
        }, status=status.HTTP_200_OK)
    except Exception as e:
        return JsonResponse(
            {"error": "Erro ao gerar token"}, 
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

class SistemaDeSegurancaListCreateAPIView(generics.ListCreateAPIView):
    queryset = SistemaDeSeguranca.objects.all()
    serializer_class = SistemaDeSegurancaSerializer

    def perform_create(self, serializer):
        serializer.save()

class RodoviaListCreateAPIView(generics.ListCreateAPIView):
    queryset = Rodovia.objects.all()
    serializer_class = RodoviaSerializer
@csrf_exempt
def verificar_email(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            email = data.get('email', '').strip()

            # Check for empty CPF
            if not email:
                return JsonResponse({'success': False, 'message': 'email cannot be empty'}, status=400)

            # Validate CPF format (optional)
            # You can add logic here to validate the CPF format using a regular expression
            # or a third-party library. If validation fails, return an appropriate error response.

            # Query the database for user with matching CPF
            try:
                user = CustomUser.objects.get(email=email)
                return JsonResponse({
                    'success': True,
                    'user': {
                        'id': user.id,
                    }
                })
            except CustomUser.DoesNotExist:
                return JsonResponse({'success': False, 'message': 'email not found'}, status=404)

        except Exception as e:
            print(f"Error verifying CPF: {e}")  # Log the error for debugging
            return JsonResponse({'success': False, 'message': 'Internal server error'}, status=500)

    return JsonResponse({'success': False, 'message': 'Method not allowed'}, status=405)

class AlimentosEBebidasListCreateView(generics.ListCreateAPIView):
    queryset = AlimentosEBebidas.objects.all()
    serializer_class = AlimentosEBebidasSerializer


class AlimentosEBebidasUpdateAPIView(generics.UpdateAPIView):
    queryset = AlimentosEBebidas.objects.all()
    serializer_class = AlimentosEBebidasSerializer

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.update(request, *args, **kwargs)

class AlterPasswordView(generics.UpdateAPIView):
    serializer_class = ChangePasswordSerializer
    queryset = CustomUser.objects.all()

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
    
        user = self.get_object()

        serializer = self.get_serializer(data=request.data)
        try:
            serializer.is_valid(raise_exception=True)
        except serializers.ValidationError as e:
            print("Validation errors:", e.detail)
            return Response({"error": e.detail}, status=400)
    
        user.set_password(serializer.validated_data['new_password'])
        user.save()

        return Response({"sucess": "Password changed sucessfully"})

class EquipamentosListView(APIView):
    def get(self, request, *args, **kwargs):
        pesquisa_id = request.query_params.get('pesquisa_id')

        if not pesquisa_id:
            raise ValidationError({"detail": "O parâmetro 'pesquisa_id' é obrigatório."})

        # Rodovias
        rodovias = Rodovia.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        rodovias_serialized = [
            {"tipo": "Rodovia", "dados": RodoviaSerializer(rodovia).data}
            for rodovia in rodovias
        ]

        # Sistemas de Segurança
        sistemas = SistemaDeSeguranca.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        sistemas_serialized = [
            {"tipo": "SistemaDeSeguranca", "dados": SistemaDeSegurancaSerializer(sistema).data}
            for sistema in sistemas
        ]

        alimentos = AlimentosEBebidas.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        alimentos_serialized = [
            {"tipo": "AlimentosEBebidas", "dados": AlimentosEBebidasSerializer(alimento).data}
            for alimento in alimentos
        ]        

        # Combina os dados
        equipamentos = rodovias_serialized + sistemas_serialized + alimentos_serialized

        return Response(equipamentos)


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
    
class SistemaDeSegurancaUpdateAPIView(generics.UpdateAPIView):
    queryset = SistemaDeSeguranca.objects.all()
    serializer_class = SistemaDeSegurancaSerializer

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


class BaseViewSet(viewsets.ModelViewSet):
    queryset = Base.objects.all()
    serializer_class = DynamicBaseSerializer
    

    def update(self, request, *args, **kwargs):
        instance = get_object_or_404(Base, id=kwargs.get('pk'))  # Obtém o objeto apenas pelo ID
        serializer = self.get_serializer(instance, data=request.data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
         
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LogoutAPIView(APIView):
    permission_classes = [permissions.AllowAny] 

    def post(self, request):
        try:
            refresh_token = request.data.get("refresh")
            token = RefreshToken(refresh_token)

            token.blacklist()
            return Response({"detail": "Logout realizado com sucesso."}, status=status.HTTP_205_RESET_CONTENT)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)