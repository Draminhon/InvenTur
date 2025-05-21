from rest_framework import  permissions, viewsets, status, views
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse

class PesquisaViewSet(viewsets.ModelViewSet):

    queryset = Pesquisa.objects.filter(is_active=True)
    serializer_class = PesquisaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)





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