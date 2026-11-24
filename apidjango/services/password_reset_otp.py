from datetime import date, datetime
from django.core.mail import send_mail
from django.utils import timezone
from rest_framework import generics, permissions, viewsets, status
from ..models import *
from ..serializers import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.throttling import AnonRateThrottle


# Limites por IP: sem eles, o código de 6 dígitos poderia ser descoberto por tentativa e erro
class PedirCodigoThrottle(AnonRateThrottle):
    scope = 'senha_pedir_codigo'
    rate = '3/min'


class ValidarCodigoThrottle(AnonRateThrottle):
    scope = 'senha_validar_codigo'
    rate = '5/min'


class TrocarSenhaThrottle(AnonRateThrottle):
    scope = 'senha_trocar'
    rate = '5/min'
  

class PasswordResetRequestAPIView(APIView):
    permission_classes = []
    throttle_classes = [PedirCodigoThrottle]

    def post(self, request):
        serializer = PasswordResetRequestSerializer(data=request.data)
        if serializer.is_valid():
            return Response(
                {"success": True, "message": "OTP sent to email."}, 
                status=status.HTTP_200_OK
            )
        return Response(
            {"success": False, "errors": serializer.errors}, 
            status=status.HTTP_400_BAD_REQUEST
        )


class OTPVerificationAPIView(APIView):
    permission_classes = []
    throttle_classes = [ValidarCodigoThrottle]

    def post(self, request):
        serializer = OTPVerificationSerializer(data=request.data)
        if serializer.is_valid():
            return Response(
                {"success": True, "message": "OTP verified successfully."},
                status=status.HTTP_200_OK,
            )
        return Response(
            {"success": False, "errors": serializer.errors},
            status=status.HTTP_400_BAD_REQUEST,
        )

class PasswordResetAPIView(APIView):
    permission_classes = []
    throttle_classes = [TrocarSenhaThrottle]

    def post(self, request):
        serializer = PasswordResetSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(
                {"success": True, "message": "Password reset successfully."},
                status=status.HTTP_200_OK,
            )
        return Response(
            {"success": False, "errors": serializer.errors},
            status=status.HTTP_400_BAD_REQUEST,
        )