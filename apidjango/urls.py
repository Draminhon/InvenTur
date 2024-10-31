from django.urls import path
from .views import UsuarioCreateView,  UsuarioListView, UsuarioLoginView, RodoviaListCreateAPIView, RodoviaListView

urlpatterns = [
    path('cadastro/', UsuarioCreateView.as_view(), name = 'usuario-create'),
    path('usuarios/', UsuarioListView.as_view(), name = 'usuario-list'),
    path('login/', UsuarioLoginView, name = 'usuario-login'),
    path('rodovias/', RodoviaListCreateAPIView.as_view(), name = 'rodovia-see' ),
    path('rodoviass/', RodoviaListView.as_view(), name = 'rodovia-se' ),
] 