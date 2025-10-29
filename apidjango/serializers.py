from rest_framework import serializers
from .models import *
from apidjango.models import validate_cpf
from django.core.mail import send_mail
from django.utils.timezone import now, timedelta

class ChangePasswordSerializer(serializers.Serializer):
    new_password = serializers.CharField(write_only=True, required=True)

    def validate_new_password(self, value):
        # Validação customizada (se necessário, por exemplo, força mínima, etc.)
        if len(value) < 8:
            raise serializers.ValidationError("A senha deve ter pelo menos 8 caracteres.")
        return value

class UserSerializer(serializers.ModelSerializer):
    pesquisas = serializers.PrimaryKeyRelatedField(
        many = True,
        queryset = Pesquisa.objects.all(),
        required=False
        )
        
    class Meta:
        model = CustomUser
        fields = ['id','username', 'CPF', 'email', 'password', 'is_active',  'acessLevel', 'status', 'password', 'telefone', 'pesquisas']
        extra_kwargs = {'password': {'write_only': True, 'required': False, 'allow_blank': True}}


    def create(self, validated_data):
        pesquisas_data = validated_data.pop('pesquisas', [])
        user = CustomUser(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        if pesquisas_data:
            user.pesquisas.set(pesquisas_data)
        return user
    
    def update(self, instance, validated_data):
        pesquisas_data = validated_data.pop('pesquisas', None)
        password = validated_data.pop('password', None)
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        if password and password.strip() != "":
            instance.set_password(password)
        instance.save()
        
        if pesquisas_data is not None:
            instance.pesquisas.set(pesquisas_data)
        return instance
    
    def validate_CPF(self, value):
        validate_cpf(value)
        return value 

class PesquisaSerializer(serializers.ModelSerializer):



    quantidadePesquisadores = serializers.IntegerField(source='usuario.count', read_only = True)
    usuario = serializers.PrimaryKeyRelatedField(queryset=CustomUser.objects.all(), many=True)
    admin_email = serializers.ReadOnlyField(source='admin.email')
    admin_telefone = serializers.ReadOnlyField(source='admin.telefone')
    quantidadeLocais = serializers.SerializerMethodField()

    
    class Meta:
        model = Pesquisa
        fields = '__all__'

    def update(self, instance, validated_data):
        return super().update(instance, validated_data) 
    
    def get_quantidadeLocais(self, obj):
        return obj.bases.filter(is_active=True).count()

class ContatoInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContatoInfo
        fields = ['nome', 'endereco', 'whatsapp', 'email']

class ServicoEspecializadoInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ServicoEspecializadoInfo
        fields = ['email', 'servicos_especializados', 'outras_informacoes']

class InfoGeraisSerializer(serializers.ModelSerializer):
    class Meta:
        model = InfoGerais
        fields = ['razao_social', 'nome_fantasia', 'cnpj', 'endereco', 'telefone']

class EnderecoInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = EnderecoInfo
        fields = ['email', 'site', 'tipoImoveis', 'outrasInfo']

class LocadorasDeImoveisSerializer(serializers.ModelSerializer):
    contatos = InfoGeraisSerializer(many=True)  # Aninhando os dados completos
    servicos_especializados = EnderecoInfoSerializer(many=True)

    
    class Meta:
        model = LocadorasDeImoveis
        fields = [
            'id', 'pesquisa', 'contatos', 'servicos_especializados',
            'tipo_formulario', 'uf', 'regiao_turistica', 'municipio',
            'tipo', 'observacoes', 'referencias',
            'nome_pesquisador', 'telefone_pesquisador', 'email_pesquisador',
            'nome_coordenador', 'telefone_coordenador', 'email_coordenador'
        ]

    def create(self, validated_data):
        contatos_data = validated_data.pop('contatos', [])
        servicos_data = validated_data.pop('servicos_especializados', [])
        
        sistema_de_seguranca = LocadorasDeImoveis.objects.create(**validated_data)
        
        for contato_data in contatos_data:
            contato = InfoGerais.objects.create(**contato_data)
            sistema_de_seguranca.contatos.add(contato)
        
        for servico_data in servicos_data:
            servico = EnderecoInfo.objects.create(**servico_data)
            sistema_de_seguranca.servicos_especializados.add(servico)
        
        return sistema_de_seguranca

    def update(self, instance, validated_data):
        contatos_data = validated_data.pop('contatos', None)
        servicos_data = validated_data.pop('servicos_especializados', None)
        
        instance.tipo_formulario = validated_data.get('tipo_formulario', instance.tipo_formulario)
        instance.uf = validated_data.get('uf', instance.uf)
        instance.regiao_turistica = validated_data.get('regiao_turistica', instance.regiao_turistica)
        instance.municipio = validated_data.get('municipio', instance.municipio)
        instance.tipo = validated_data.get('tipo', instance.tipo)
        instance.observacoes = validated_data.get('observacoes', instance.observacoes)
        instance.referencias = validated_data.get('referencias', instance.referencias)
        instance.nome_pesquisador = validated_data.get('nome_pesquisador', instance.nome_pesquisador)
        instance.telefone_pesquisador = validated_data.get('telefone_pesquisador', instance.telefone_pesquisador)
        instance.email_pesquisador = validated_data.get('email_pesquisador', instance.email_pesquisador)
        instance.nome_coordenador = validated_data.get('nome_coordenador', instance.nome_coordenador)
        instance.telefone_coordenador = validated_data.get('telefone_coordenador', instance.telefone_coordenador)
        instance.email_coordenador = validated_data.get('email_coordenador', instance.email_coordenador)

        # Salva os campos principais atualizados
        instance.save()

        
        if contatos_data is not None:
            instance.contatos.clear()
            for contato_data in contatos_data:
                contato = InfoGerais.objects.create(**contato_data)
                instance.contatos.add(contato)
        
        if servicos_data is not None:
            instance.servicos_especializados.clear()
            for servico_data in servicos_data:
                servico = EnderecoInfo.objects.create(**servico_data)
                instance.servicos_especializados.add(servico)
        
        return instance

class SistemaDeSegurancaSerializer(serializers.ModelSerializer):
    contatos = ContatoInfoSerializer(many=True)  # Aninhando os dados completos
    servicos_especializados = ServicoEspecializadoInfoSerializer(many=True)

    
    class Meta:
        model = SistemaDeSeguranca
        fields = [
            'id', 'pesquisa', 'contatos', 'servicos_especializados',
            'tipo_formulario', 'uf', 'regiao_turistica', 'municipio',
            'tipo', 'observacoes', 'referencias',
            'nome_pesquisador', 'telefone_pesquisador', 'email_pesquisador',
            'nome_coordenador', 'telefone_coordenador', 'email_coordenador'
        ]

    def create(self, validated_data):
        contatos_data = validated_data.pop('contatos', [])
        servicos_data = validated_data.pop('servicos_especializados', [])
        
        sistema_de_seguranca = SistemaDeSeguranca.objects.create(**validated_data)
        
        for contato_data in contatos_data:
            contato = ContatoInfo.objects.create(**contato_data)
            sistema_de_seguranca.contatos.add(contato)
        
        for servico_data in servicos_data:
            servico = ServicoEspecializadoInfo.objects.create(**servico_data)
            sistema_de_seguranca.servicos_especializados.add(servico)
        
        return sistema_de_seguranca

    def update(self, instance, validated_data):
        contatos_data = validated_data.pop('contatos', None)
        servicos_data = validated_data.pop('servicos_especializados', None)
        
        instance.tipo_formulario = validated_data.get('tipo_formulario', instance.tipo_formulario)
        instance.uf = validated_data.get('uf', instance.uf)
        instance.regiao_turistica = validated_data.get('regiao_turistica', instance.regiao_turistica)
        instance.municipio = validated_data.get('municipio', instance.municipio)
        instance.tipo = validated_data.get('tipo', instance.tipo)
        instance.observacoes = validated_data.get('observacoes', instance.observacoes)
        instance.referencias = validated_data.get('referencias', instance.referencias)
        instance.nome_pesquisador = validated_data.get('nome_pesquisador', instance.nome_pesquisador)
        instance.telefone_pesquisador = validated_data.get('telefone_pesquisador', instance.telefone_pesquisador)
        instance.email_pesquisador = validated_data.get('email_pesquisador', instance.email_pesquisador)
        instance.nome_coordenador = validated_data.get('nome_coordenador', instance.nome_coordenador)
        instance.telefone_coordenador = validated_data.get('telefone_coordenador', instance.telefone_coordenador)
        instance.email_coordenador = validated_data.get('email_coordenador', instance.email_coordenador)

        # Salva os campos principais atualizados
        instance.save()

        
        if contatos_data is not None:
            instance.contatos.clear()
            for contato_data in contatos_data:
                contato = ContatoInfo.objects.create(**contato_data)
                instance.contatos.add(contato)
        
        if servicos_data is not None:
            instance.servicos_especializados.clear()
            for servico_data in servicos_data:
                servico = ServicoEspecializadoInfo.objects.create(**servico_data)
                instance.servicos_especializados.add(servico)
        
        return instance

class RodoviaSerializer(serializers.ModelSerializer):
    # tipo_de_organizacao_instituicao = serializers.PrimaryKeyRelatedField(many=True, queryset=TipoOrganizacao.objects.all())
    # posto_de_combustivel = serializers.PrimaryKeyRelatedField(many=True, queryset=PostoDeCombustivel.objects.all())
    # outros_servicos = serializers.PrimaryKeyRelatedField(many=True, queryset=OutrosServicos.objects.all())
    # estruturas_ao_longo_da_vida = serializers.PrimaryKeyRelatedField(many=True, queryset=EstruturasAoLongoDaVia.objects.all())

    class Meta:
        model = Rodovia
        fields = '__all__'  # ou especifique os campos que você deseja incluir

class AlimentosEBebidasSerializer(serializers.ModelSerializer):

    class Meta:
        model = AlimentosEBebidas
        fields = '__all__'

class MeioDeHospedagemSerializer(serializers.ModelSerializer):
    class Meta:
        model = MeioDeHospedagem
        fields = '__all__'

class OutrosMeiosDeHospedagemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OutrosMeiosDeHospedagem
        fields = '__all__'

class AgenciaDeTurismoSerializer(serializers.ModelSerializer):
    class Meta:
        model = AgenciaDeTurismo
        fields = '__all__'

class TransporteTuristicoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TransporteTuristico
        fields = '__all__'
        
class ComercioTuristicoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ComercioTuristico
        fields = '__all__'

class EspacoParaEventosSerializer(serializers.ModelSerializer):
    class Meta:
        model = EspacoParaEventos
        fields = '__all__'
        
class ServicosParaEventosSerializer(serializers.ModelSerializer):
    class Meta:
        model = ServicosParaEventos
        fields = '__all__'

class ParquesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Parques
        fields = '__all__'


class InformacoesBasicasSerializer(serializers.ModelSerializer):
    class Meta:
        model = InformacaoBasicaDoMunicipio
        fields = '__all__'

class EquipamentoSerializer(serializers.Serializer):
    tipo = serializers.CharField()
    dados = serializers.JSONField()

class DynamicBaseSerializer(serializers.ModelSerializer):

    class Meta:
        model = Base
        fields = '__all__'

class PasswordResetRequestSerializer(serializers.Serializer):
    email = serializers.EmailField()

    def validate_email(self, value):
        try:
            user = CustomUser.objects.get(email=value)
        except CustomUser.DoesNotExist:
            raise serializers.ValidationError("Nenhum usuário com esse email foi encontrado")

        user.generate_otp()
        send_mail(
            "Código para recuperar sua senha",
            f"Seu código para recuperar sua senha é: {user.otp}",
            "britomurilorog@gmail.com",
            [user.email],
            fail_silently=False
        )
        return value

class OTPVerificationSerializer(serializers.Serializer):
    email = serializers.EmailField()
    otp = serializers.CharField(max_length=6)

    def validate(self, data):
        try:
            user = CustomUser.objects.get(email=data["email"])
        except CustomUser.DoesNotExist:   
            raise serializers.ValidationError({"email": "usuário não encontrado."})
        
        if user.otp!=data["otp"]:
            raise serializers.ValidationError({"otp": "OTP invalido"})
        
        if user.otp_exp < now():
            raise serializers.ValidationError({"otp": "OTP expirado"})

        user.otp_verified = True
        user.save()

        return data

class PasswordResetSerializer(serializers.Serializer):
    email = serializers.EmailField()
    new_password = serializers.CharField(write_only=True)

    def validate(self, data):
        try:
            user = CustomUser.objects.get(email=data["email"])
        except CustomUser.DoesNotExist:
            raise serializers.ValidationError({"email": "user não encontrado"})

        if not user.otp_verified:
            raise serializers.ValidationError({"otp": "verificação por OTP necessária"})
        
        return data

    
    def save(self, **kwargs):
        user = CustomUser.objects.get(email=self.validated_data["email"])
        user.set_password(self.validated_data["new_password"])
        user.otp = None  # Clear OTP after successful reset
        user.otp_exp = None
        user.otp_verified = False  # Reset verification status
        user.save()
        return user