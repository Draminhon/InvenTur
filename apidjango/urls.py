from django.urls import path
from .views import *

urlpatterns = [
    path('register/', UsuarioCreateView.as_view(), name = 'usuario-create'),
    path('usuarios/', UsuarioListView.as_view(), name = 'usuario-list'),
    path('login/', UsuarioLoginView, name = 'usuario-login'),
    path('rodovia/create/', RodoviaListCreateAPIView.as_view(), name = 'rodovia-see' ),
    path('rodovia/get/', RodoviaListView.as_view(), name = 'rodovia-se' ),
    path('rodovia/update/<int:pk>', RodoviaUpdateAPIView.as_view(), name='rodovia-update')
] 