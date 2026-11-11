from typing import Any
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth.base_user import AbstractBaseUser
from django.http import HttpRequest
from .models import CustomUser
from .fields import EncryptionService
   
class CPFBackend(ModelBackend):
    def authenticate(self, request, CPF = None, password = None, **kwargs):
        if CPF is None:
            return None
            
        # Gera o blind index para busca determinística
        cpf_hash = EncryptionService().get_blind_index(CPF)
        
        try:
            # Busca pelo hash, não pelo campo criptografado
            user = CustomUser.objects.get(cpf_hash = cpf_hash)
        except CustomUser.DoesNotExist:
            return None
            
        if user.check_password(password):
            return user
        return None