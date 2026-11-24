from django.core.cache import cache
from django.utils import timezone
from rest_framework import  permissions, viewsets, status, views, generics
from rest_framework.permissions import IsAuthenticated
from ..termos import TERMOS_VERSAO, termos_pendentes
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from ..fields import EncryptionService
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

# Limite de tentativas de login (contra descoberta de senha por tentativa e erro).
# Conta só as tentativas ERRADAS: 5 por e-mail ou 20 por IP; ao atingir, bloqueia por 15 minutos.
LOGIN_MAX_FALHAS_EMAIL = 5
LOGIN_MAX_FALHAS_IP = 20
LOGIN_BLOQUEIO_SEGUNDOS = 15 * 60


def _ip_do_cliente(request):
    # Mesma regra dos limites do DRF: respeita DJANGO_NUM_PROXIES para achar o IP real atrás de proxy
    from rest_framework.throttling import BaseThrottle
    return BaseThrottle().get_ident(request) or ''


def _chaves_de_falha(request, email):
    return (f'login-falhas:email:{EncryptionService().get_email_index(email)}',
            f'login-falhas:ip:{_ip_do_cliente(request)}')


def _login_bloqueado(request, email):
    chave_email, chave_ip = _chaves_de_falha(request, email)
    return (cache.get(chave_email, 0) >= LOGIN_MAX_FALHAS_EMAIL or
            cache.get(chave_ip, 0) >= LOGIN_MAX_FALHAS_IP)


def _registrar_falha_de_login(request, email):
    for chave in _chaves_de_falha(request, email):
        cache.add(chave, 0, LOGIN_BLOQUEIO_SEGUNDOS)
        try:
            cache.incr(chave)
        except ValueError:
            cache.set(chave, 1, LOGIN_BLOQUEIO_SEGUNDOS)


@csrf_exempt
def UsuarioLoginView(request):
    # Responde a métodos não-POST com erro 405
    if request.method != "POST":
        return JsonResponse(
            {"error": "Método não permitido"}, 
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )

    email = None
    password = None

    # Tratamento para JSON
    if request.content_type == "application/json":
        try:
            data = json.loads(request.body)
            email = data.get("email")
            password = data.get("password")
        except json.JSONDecodeError:
            return JsonResponse(
                {"error": "JSON inválido"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
    # Tratamento para form-data/x-www-form-urlencoded
    else:
        email = request.POST.get("email")
        password = request.POST.get("password")

    # Validação dos campos (tipos também: um número ou lista no lugar do texto derrubava o login com erro 500)
    if not isinstance(email, str) or not isinstance(password, str):
        email = password = None
    if not email or not password:
        return JsonResponse(
            {"error": "E-mail e senha são obrigatórios"}, 
            status=status.HTTP_400_BAD_REQUEST
        )

    if _login_bloqueado(request, email):
        return JsonResponse(
            {"error": "Muitas tentativas de login. Aguarde 15 minutos ou recupere sua senha."},
            status=status.HTTP_429_TOO_MANY_REQUESTS
        )

    # Autenticação
    user = authenticate(request, email=email, password=password)
    if user is None:
        _registrar_falha_de_login(request, email)
        return JsonResponse(
            {"error": "Credenciais inválidas"}, 
            status=status.HTTP_401_UNAUTHORIZED
        )


    cache.delete(_chaves_de_falha(request, email)[0])  # acertou: zera as falhas deste e-mail

    # Último acesso: base da regra de contas inativas (Política de Privacidade, seção 10)
    user.last_login = timezone.now()
    user.aviso_inatividade_em = None
    user.save(update_fields=['last_login', 'aviso_inatividade_em'])

    # Só pesquisas ativas: excluir uma pesquisa marca is_active=False, e ela não deve ir para o cache offline do app
    pesquisas_qs = user.usuario.filter(is_active=True).prefetch_related('admin')

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
                "name": user.username,
                "pesquisas": pesquisas_data,
                "email": user.email,
                "access_level": user.acessLevel,
                "status": user.status,
                "telefone": user.telefone,
                "foto_perfil": user.foto_perfil.url if user.foto_perfil else None
            },
            # O app pede o aceite dos Termos/Política antes de liberar o acesso quando houver pendência
            "termos_pendentes": termos_pendentes(user),
            "termos_versao": TERMOS_VERSAO,
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
