from django.urls import path
from .views import UsuarioCreateView,  UsuarioListView, UsuarioLoginView

urlpatterns = [
    path('cadastro/', UsuarioCreateView.as_view(), name = 'usuario-create'),
    path('usuarios/', UsuarioListView.as_view(), name = 'usuario-list'),
    path('login/', UsuarioLoginView, name = 'usuario-login'),
] 