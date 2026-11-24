from typing import Any
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth.base_user import AbstractBaseUser
from django.http import HttpRequest
from .models import CustomUser
from .fields import EncryptionService
   
class EmailBackend(ModelBackend):
    """Autentica pelo e-mail (normalizado) e senha. O e-mail é criptografado no banco, então a busca
    é feita pelo blind index (email_hash, único)."""

    def authenticate(self, request, email=None, password=None, **kwargs):
        if not email or not password:
            return None
        try:
            user = CustomUser.objects.get(email_hash=EncryptionService().get_email_index(email))
        except CustomUser.DoesNotExist:
            # Mesmo custo de uma verificação real, para não revelar pelo tempo se o e-mail existe
            CustomUser().set_password(password)
            return None
        if user.check_password(password) and self.user_can_authenticate(user):
            return user
        return None
