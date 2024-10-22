from rest_framework import generics
from .serializers import UserSerializer
from .models import CustomUser
from rest_framework.response import Response
from rest_framework import status

class UsuarioCreateView(generics.ListCreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status = status.HTTP_201_CREATED, headers=headers)
    
class UsuarioListView(generics.ListAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer