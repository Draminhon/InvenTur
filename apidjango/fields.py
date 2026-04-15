import hashlib
import hmac
from django.db import models
from django.conf import settings
from cryptography.fernet import Fernet
import base64
  
class EncryptionService:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            # First, derive the key
            key = getattr(settings, 'FIELD_ENCRYPTION_KEY', None)
            if key:
                if isinstance(key, str):
                    key = key.encode()
            
            # Try to create Fernet instance first. If it fails, _instance won't be set.
            try:
                fernet = Fernet(key)
                instance = super(EncryptionService, cls).__new__(cls)
                instance.fernet = fernet
                cls._instance = instance
            except Exception as e:
                # Log or re-raise. For now, re-raise to know what's wrong.
                raise ValueError(f"Invalid encryption key provided: {e}")
        return cls._instance

    def encrypt(self, value):
        if value is None:
            return None
        if not isinstance(value, str):
            value = str(value)
        return self.fernet.encrypt(value.encode()).decode()

    def decrypt(self, encrypted_value):
        if encrypted_value is None:
            return None
        try:
            return self.fernet.decrypt(encrypted_value.encode()).decode()
        except Exception:
            # If decryption fails, return the original value (might be plaintext during migration)
            return encrypted_value

    def get_blind_index(self, value):
        """Gera um hash determinístico para buscas exatas."""
        if value is None:
            return None
        key = settings.SECRET_KEY.encode()
        h = hmac.new(key, str(value).encode(), hashlib.sha256)
        return h.hexdigest()

class EncryptedCharField(models.CharField):
    """Campo que armazena dados criptografados no banco de dados."""
    
    def __init__(self, *args, **kwargs):
        # Aumentamos o max_length pois a criptografia expande o texto
        if 'max_length' in kwargs:
            kwargs['max_length'] = kwargs['max_length'] * 4 + 100
        super().__init__(*args, **kwargs)

    def from_db_value(self, value, expression, connection):
        if value is None:
            return value
        return EncryptionService().decrypt(value)

    def to_python(self, value):
        if value is None:
            return value
        # to_python é chamado em formulários e limpeza; o valor pode estar limpo ou criptografado
        # Se for um valor do DB via from_db_value, já estará limpo. 
        return value

    def get_prep_value(self, value):
        if value is None:
            return value
        return EncryptionService().encrypt(str(value))

class EncryptedTextField(models.TextField):
    """Versão TextField para dados criptografados longos."""
    
    def from_db_value(self, value, expression, connection):
        if value is None:
            return value
        return EncryptionService().decrypt(value)

    def get_prep_value(self, value):
        if value is None:
            return value
        return EncryptionService().encrypt(str(value))

class BlindIndexField(models.CharField):
    """
    Campo auxiliar que armazena um hash do valor original para buscas rápidas e restrições unique.
    Deve ser preenchido manualmente ou via sinal/save no modelo.
    """
    def __init__(self, *args, **kwargs):
        kwargs['max_length'] = 64 # SHA-256 hex length
        kwargs['editable'] = False
        super().__init__(*args, **kwargs)
