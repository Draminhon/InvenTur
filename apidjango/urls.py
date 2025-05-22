from django.urls import path, include
from rest_framework_simplejwt.views import *
from .views import *
from .services import *
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'rodovias', RodoviaViewSet, basename='rodovia')
router.register(r'alimentosEBebidas', AlimentosEBebidasViewSet, basename='alimentos e bebidas')
router.register(r'meiosdehospedagem', MeioDeHospedagemViewSet, basename='meios de hospedagem')
router.register(r'sistemadeseguranca', SistemaDeSegurancaViewSet, basename='sistema de seguranca')
router.register(r'pesquisa', PesquisaViewSet, basename='pesquisa')
router.register(r'user', UserViewSet, basename='user')

urlpatterns = [

    path('', include(router.urls)),

    path("password-reset/request/", PasswordResetRequestAPIView.as_view(), name="password-reset-request"),
    path("password-reset/verify-otp/", OTPVerificationAPIView.as_view(), name="password-reset-verify-otp"),  # New API
    path("password-reset/change-password/", PasswordResetAPIView.as_view(), name="password-reset-change"),
    path('export/pesquisa/<int:pesquisa_id>/', export_pesquisa_to_excel, name = 'export_pesquisa'),
    path('equipamentos/',  EquipamentosListView.as_view(), name='equipamento'),
    path('base/<int:pk>/', BaseViewSet.as_view({'patch': 'update'})),
    path('user/status/update/<int:pk>/', StatusUpdateAPIView.as_view(), name='status-update'),
    path('pesquisas/usuario/', PesquisaUsuarioAuth.as_view(), name='pesquisar usuario por token'),
    path('admin/register/', AdminUserCreateView.as_view(), name = 'create-admin'),

    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name = 'token_refresh'),

    path('admin/<int:admin_id>/', get_admin_details, name = 'get_admin_details'),
    path('verificarcpf/', verificar_email, name ='verificar-cpf'),
    path('user/<int:pk>/change-password/', AlterPasswordView.as_view(), name ='alter password'),
    path('login/', UsuarioLoginView, name = 'usuario-login'),
    path('logout/', LogoutAPIView.as_view(), name ='logout'),
] 