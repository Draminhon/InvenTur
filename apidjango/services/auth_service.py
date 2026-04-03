from rest_framework import  permissions, viewsets, status, views, generics
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.views import APIView
from rest_framework.response import Response
import json
import threading
import time
from django.contrib.auth import authenticate, login
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenRefreshView

 
class SessionMonitor:
    _instance = None
    _stop_event = threading.Event()
    _thread = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(SessionMonitor, cls).__new__(cls)
        return cls._instance

    def _run_countdown(self):
        print("\n" + "="*50)
        print("▶️ MONITOR: Sessão Iniciada! Expiração em 5 min.")
        print("="*50 + "\n")
        
        for i in range(1, 6):
            if self._stop_event.wait(60):
                return
            print(f"🕒 MONITOR: {i}/5 minutos decorridos...")
        
        print("\n" + "!"*50)
        print("⚠️ MONITOR: 5 min atingidos! O Access Token expirou.")
        print("!"*50 + "\n")

    def start(self):
        self.stop()
        self._stop_event.clear()
        self._thread = threading.Thread(target=self._run_countdown, daemon=True)
        self._thread.start()

    def stop(self):
        self._stop_event.set()

monitor = SessionMonitor()

class DecoratedTokenRefreshView(TokenRefreshView):
    def post(self, request, *args, **kwargs):
        response = super().post(request, *args, **kwargs)
        if response.status_code == 200:
            print("\n" + "♻️"*20)
            print("♻️  REFRESH TOKEN ATIVADO! Renovando sessão...")
            print("♻️"*20 + "\n")
            monitor.start()
        return response

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


    pesquisas_qs = user.usuario.prefetch_related('admin')

    pesquisas_data = PesquisaSerializer(pesquisas_qs, many=True).data
    
    # Geração do token JWT
    try:
        refresh = RefreshToken.for_user(user)
        monitor.start() # Inicia contador no terminal
        return JsonResponse({
            "refresh": str(refresh),
            "access": str(refresh.access_token),
            "access_exp": refresh.access_token['exp'],
            "user": {
                "id": user.id,
                "CPF": user.CPF,
                "name": user.username,
                "pesquisas": pesquisas_data,
                "email": user.email,
                "access_level": user.acessLevel,
                "status": user.status,
                "telefone": user.telefone
            } 
        }, status=status.HTTP_200_OK)
    except Exception as e:
        return JsonResponse(
            {"error": "Erro ao gerar token"}, 
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

class LogoutAPIView(APIView):

    permission_classes = [permissions.AllowAny] 

    def post(self, request):
        try:
            refresh_token = request.data.get("refresh")
            token = RefreshToken(refresh_token)
            token.blacklist()
            monitor.stop() # Para contador no terminal

            return Response({"detail": "Logout realizado com sucesso."}, status=status.HTTP_205_RESET_CONTENT)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

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

@csrf_exempt
def verificar_email(request):
    permission_classes = [permissions.AllowAny] 

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
