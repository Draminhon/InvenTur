from rest_framework import serializers
from .models import CustomUser
from apidjango.models import validate_cpf

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = CustomUser
        fields = ['username', 'CPF', 'email', 'password']
        exxtra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = CustomUser(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user
    
    def validate_CPF(self, value):
        validate_cpf(value)
        return value