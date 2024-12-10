from django.urls import path
from rest_framework_simplejwt.views import *
from .views import *



urlpatterns = [
    path('register/', UsuarioCreateView.as_view(), name = 'usuario-create'),
    path('usuarios/', UsuarioListView.as_view(), name = 'usuario-list'),
    path('login/', UsuarioLoginView, name = 'usuario-login'),
    path('pesquisas/usuario/', PesquisaUsuarioListView.as_view(), name='pesquisa-usuario-list'),

    path('rodovia/create/', RodoviaListCreateAPIView.as_view(), name = 'rodovia-see' ),
    path('rodovia/get/', RodoviaListView.as_view(), name = 'rodovia-se' ),
    path('rodovia/update/<int:pk>', RodoviaUpdateAPIView.as_view(), name='rodovia-update'),

    path('usuarios/status/update/<int:pk>/', StatusUpdateAPIView.as_view(), name='status-update'),
    path('usuarios/update/<int:pk>', AlterUserAPIView.as_view(), name = 'delete-user'),
    path('usuarios/register/admin', AdminUserCreateView.as_view(), name = 'create-admin'),

    path('pesquisa/create', PesquisaCreateView.as_view(), name = 'pesquisa-create'),
    path('pesquisa/update/<int:pk>', AlterPesquisaAPIView.as_view(), name = 'pesquisa-create'),
    path('pesquisa/status/update/<int:pk>/', PesquisaStatusUpdateAPIView.as_view(), name = 'pesquisa-status-update'),

    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name = 'token_refresh'),

    path('admin/<int:admin_id>/', get_admin_details, name = 'get_admin_details')
] 