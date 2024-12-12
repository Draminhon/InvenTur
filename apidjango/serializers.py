from rest_framework import serializers
from .models import *
from apidjango.models import validate_cpf

class ChangePasswordSerializer(serializers.Serializer):
    new_password = serializers.CharField(write_only=True, required=True)

    def validate_new_password(self, value):
        # Validação customizada (se necessário, por exemplo, força mínima, etc.)
        if len(value) < 8:
            raise serializers.ValidationError("A senha deve ter pelo menos 8 caracteres.")
        return value


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = CustomUser
        fields = ['id','username', 'CPF', 'email', 'password', 'is_active',  'acessLevel', 'status', 'password' ]
        extra_kwargs = {'password': {'write_only': True,}}

    def create(self, validated_data):
        user = CustomUser(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user
    

    
    def validate_CPF(self, value):
        validate_cpf(value)
        return value 

class PesquisaSerializer(serializers.ModelSerializer):

    quantidadePesquisadores = serializers.IntegerField(source='usuario.count', read_only = True)
    usuario = serializers.PrimaryKeyRelatedField(queryset=CustomUser.objects.all(), many=True)

    class Meta:
        model = Pesquisa
        fields = '__all__'




    

class RodoviaSerializer(serializers.ModelSerializer):
    # tipo_de_organizacao_instituicao = serializers.PrimaryKeyRelatedField(many=True, queryset=TipoOrganizacao.objects.all())
    # posto_de_combustivel = serializers.PrimaryKeyRelatedField(many=True, queryset=PostoDeCombustivel.objects.all())
    # outros_servicos = serializers.PrimaryKeyRelatedField(many=True, queryset=OutrosServicos.objects.all())
    # estruturas_ao_longo_da_vida = serializers.PrimaryKeyRelatedField(many=True, queryset=EstruturasAoLongoDaVia.objects.all())

    class Meta:
        model = Rodovia
        fields = '__all__'  # ou especifique os campos que você deseja incluir