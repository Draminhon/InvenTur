from django.urls import path
from .views import UsuarioCreateView,  UsuarioListView

urlpatterns = [
    path('cadastro/', UsuarioCreateView.as_view(), name = 'usuario-create'),
    path('usuarios/', UsuarioListView.as_view(), name = 'usuario-list'),
    path('login/', my_view, name = 'usuario-login'),
]