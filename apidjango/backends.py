from typing import Any
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth.base_user import AbstractBaseUser
from django.http import HttpRequest
from .models import CustomUser
 
class CPFBackend(ModelBackend):
    def authenticate(self, request, CPF = None, password = None, **kwargs):
        try:
            user = CustomUser.objects.get(CPF = CPF)
        except CustomUser.DoesNotExist:
            return None
        if user.check_password(password):
            return user
        return None