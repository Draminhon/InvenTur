from django.urls import path
from rest_framework_simplejwt.views import *
from .views import *



urlpatterns = [
    path('register/', UsuarioCreateView.as_view(), name = 'usuario-create'),
    path('usuarios/', UsuarioListView.as_view(), name = 'usuario-list'),
    path('login/', UsuarioLoginView, name = 'usuario-login'),
    path('pesquisas/usuario/', PesquisaUsuarioListView.as_view(), name='pesquisa-usuario-list'),

    path("password-reset/request/", PasswordResetRequestAPIView.as_view(), name="password-reset-request"),
    path("password-reset/verify-otp/", OTPVerificationAPIView.as_view(), name="password-reset-verify-otp"),  # New API
    path("password-reset/change-password/", PasswordResetAPIView.as_view(), name="password-reset-change"),

    path('export/pesquisa/<int:pesquisa_id>/', export_pesquisa_to_excel, name = 'export_pesquisa'),

    path('alimentosEBebidas/create/', AlimentosEBebidasListCreateView.as_view(), name = 'createAlimentos'),
    path('alimentosEBebidas/update/<int:pk>', AlimentosEBebidasUpdateAPIView.as_view(), name = 'updateAlimentos'),

    path('meiosdehospedagem/create/', MeiosDeHospedagemListCreateView.as_view(), name = 'meiosDeHospdagem'),
    path('meiosdehospedagem/update/<int:pk>', MeiosDeHospedagensUpdateAPIView.as_view(), name ='updateMeiosDeHospedagem'),

    path('rodovia/create/', RodoviaListCreateAPIView.as_view(), name = 'rodovia-see' ),
    path('rodovia/get/', RodoviaListView.as_view(), name = 'rodovia-se' ),
    path('rodovia/update/<int:pk>', RodoviaUpdateAPIView.as_view(), name='rodovia-update'),
    path('equipamentos/',  EquipamentosListView.as_view(), name='equipamento'),
    path('sistemaseguranca/create/', SistemaDeSegurancaListCreateAPIView.as_view(), name = 'sistemaDeSeguranca-create'),
    path('sistemadeseguranca/update/<int:pk>', SistemaDeSegurancaUpdateAPIView.as_view(), name ='sistemaDeSeguranca-update'),
    path('base/<int:pk>/', BaseViewSet.as_view({'patch': 'update'})),

    path('usuarios/status/update/<int:pk>/', StatusUpdateAPIView.as_view(), name='status-update'),
    path('usuarios/update/<int:pk>', AlterUserAPIView.as_view(), name = 'delete-user'),
    path('usuarios/register/admin', AdminUserCreateView.as_view(), name = 'create-admin'),

    path('pesquisa/create', PesquisaCreateView.as_view(), name = 'pesquisa-create'),
    path('pesquisa/update/<int:pk>', AlterPesquisaAPIView.as_view(), name = 'pesquisa-create'),
    path('pesquisa/status/update/<int:pk>/', PesquisaStatusUpdateAPIView.as_view(), name = 'pesquisa-status-update'),

    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name = 'token_refresh'),

    path('admin/<int:admin_id>/', get_admin_details, name = 'get_admin_details'),

    path('verificarcpf/', verificar_email, name ='verificar-cpf'),
    path('user/<int:pk>/change-password/', AlterPasswordView.as_view(), name ='alter password'),

    path('pesquisa/<int:pk>/atualizar/', PesquisaPartialUpdateAPIView.as_view(), name ='pesquisa-partial-update'),

    path('logout/', LogoutAPIView.as_view(), name ='logout'),
] 