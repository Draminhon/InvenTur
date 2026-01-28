from rest_framework import  permissions, viewsets, status, views
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from rest_framework.decorators import action
class PesquisaViewSet(viewsets.ModelViewSet):
  
    queryset = Pesquisa.objects.filter(is_active=True)
    serializer_class = PesquisaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

    @action(detail=True, methods=['patch'], url_path='remover-pesquisador')
    def remover_pesquisador(self, request, pk=None):
        pesquisa = self.get_object()
        user_id = request.data.get('user_id')
        print(f"Tentando remover user_id: {user_id} da pesquisa {pesquisa.id}")
        if user_id is None:
            return Response({"detail": "user_id é obrigatório"}, status=status.HTTP_400_BAD_REQUEST)
        user = get_object_or_404(CustomUser, id=user_id)
        if not pesquisa.usuario.filter(id=user.id).exists():
            return Response({"detail": "usuário não está associado a essa pesquisa"}, status=status.HTTP_400_BAD_REQUEST)
        pesquisa.usuario.remove(user)
        pesquisa.save()
        return Response({"detail": "Pesquisador removido com sucesso"}, status=status.HTTP_200_OK)


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