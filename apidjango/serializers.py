from django.conf import settings
from rest_framework import serializers
from .models import *
from .fields import EncryptionService
from django.core.mail import send_mail
from django.utils.timezone import now, timedelta
import bleach
import hmac
from django.core.cache import cache
 
class XSSSafeSerializerMixin:
    """
    Mixin to sanitize all string fields in a serializer to prevent XSS.
    """
    def to_internal_value(self, data):
        # Primeiro, obtemos os dados validados pelo DRF
        internal_value = super().to_internal_value(data)
        
        # Sanitizamos todos os campos de string
        for key, value in internal_value.items():
            if isinstance(value, str):
                # Remove todas as tags HTML e atributos
                internal_value[key] = bleach.clean(value, tags=[], attributes={}, strip=True)
            elif isinstance(value, list):
                # Sanitiza strings dentro de listas (ex: JSONField ou IDs)
                internal_value[key] = [
                    bleach.clean(v, tags=[], attributes={}, strip=True) if isinstance(v, str) else v
                    for v in value
                ]
            elif isinstance(value, dict):
                # Sanitiza dicionários recursivamente (ex: JSONField)
                internal_value[key] = self._sanitize_dict(value)
        
        return internal_value

    def _sanitize_dict(self, data):
        new_dict = {}
        for k, v in data.items():
            if isinstance(v, str):
                new_dict[k] = bleach.clean(v, tags=[], attributes={}, strip=True)
            elif isinstance(v, dict):
                new_dict[k] = self._sanitize_dict(v)
            elif isinstance(v, list):
                new_dict[k] = [
                    bleach.clean(item, tags=[], attributes={}, strip=True) if isinstance(item, str) else item
                    for item in v
                ]
            else:
                new_dict[k] = v
        return new_dict

 
class ChangePasswordSerializer(XSSSafeSerializerMixin, serializers.Serializer):
    new_password = serializers.CharField(write_only=True, required=True)

    def validate_new_password(self, value):
        # Validação customizada (se necessário, por exemplo, força mínima, etc.)
        if len(value) < 8:
            raise serializers.ValidationError("A senha deve ter pelo menos 8 caracteres.")
        return value

# Tamanho máximo da foto de perfil
TAMANHO_MAXIMO_FOTO = 5 * 1024 * 1024


class UserSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    # Somente leitura: ninguém entra numa pesquisa por aqui (só pelo código de vínculo)
    pesquisas = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
        
    class Meta:
        model = CustomUser
        fields = ['id','username', 'email', 'password', 'is_active',  'acessLevel', 'status', 'password', 'telefone', 'pesquisas', 'foto_perfil', 'pesquisas_ids']
        extra_kwargs = {'password': {'write_only': True, 'required': False, 'allow_blank': True}}


    pesquisas_ids = serializers.SerializerMethodField()

    def get_pesquisas_ids(self, obj):
        """Pesquisas ativas de quem está consultando (administrador) das quais este usuário faz parte."""
        request = self.context.get('request')
        admin = getattr(request, 'user', None)
        if not admin or not admin.is_authenticated:
            return []
        qs = obj.usuario.filter(is_active=True)
        if not admin.is_superuser:
            qs = qs.filter(admin=admin)
        return list(qs.values_list('id', flat=True))

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
    
    def validate_foto_perfil(self, value):
        if value and getattr(value, 'size', 0) > TAMANHO_MAXIMO_FOTO:
            raise serializers.ValidationError('A foto deve ter no máximo 5 MB.')
        return value

    def validate_password(self, value):
        if value and value.strip() and len(value) < 8:
            raise serializers.ValidationError('A senha deve ter pelo menos 8 caracteres.')
        return value

    def validate_email(self, value):
        # Check uniqueness using blind index
        email_hash = EncryptionService().get_email_index(value)
        user_id = self.instance.id if self.instance else None
        
        if CustomUser.objects.filter(email_hash=email_hash).exclude(id=user_id).exists():
            raise serializers.ValidationError("Este e-mail já está cadastrado.")
            
        return value
class PesquisaSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):



    quantidadePesquisadores = serializers.IntegerField(source='usuario.count', read_only = True)
    usuario = serializers.PrimaryKeyRelatedField(queryset=CustomUser.objects.all(), many=True)
    admin_email = serializers.ReadOnlyField(source='admin.email')
    admin_telefone = serializers.ReadOnlyField(source='admin.telefone')
    quantidadeLocais = serializers.SerializerMethodField()

    
    class Meta:
        model = Pesquisa
        fields = '__all__'
        # Definidos pelo servidor: o dono (na criação), o código de vínculo (gerado; trocado só por gerar-codigo)
        # e os registros de data/anonimização
        read_only_fields = ['admin', 'codigo', 'anonimizada_em', 'criacao', 'atualizacao']

    def update(self, instance, validated_data):
        return super().update(instance, validated_data)

    def validate_usuario(self, usuarios):
        """
        A equipe só cresce pelo código de vínculo (o pesquisador decide entrar). Por aqui o administrador só pode
        REMOVER pessoas (edição) ou incluir quem já tem relação com ele (criação) — senão poderia puxar qualquer
        conta do sistema para a própria pesquisa e passar a vê-la.
        """
        from .permissoes import usuarios_visiveis
        ids = {u.id for u in usuarios}
        if self.instance is not None:
            permitidos = set(self.instance.usuario.values_list('id', flat=True))
            mensagem = 'Pesquisadores só entram na pesquisa pelo código de vínculo. Aqui é possível apenas remover.'
        else:
            request = self.context.get('request')
            permitidos = set(usuarios_visiveis(request.user).values_list('id', flat=True)) if request else set()
            mensagem = 'Só é possível incluir pesquisadores que já participam das suas pesquisas.'
        if not ids <= permitidos:
            raise serializers.ValidationError(mensagem)
        return usuarios

    def validate(self, attrs):
        # A data de término precisa ser posterior à de início (numa edição parcial, compara com o valor salvo)
        inicio = attrs.get('dataInicio', getattr(self.instance, 'dataInicio', None))
        termino = attrs.get('dataTermino', getattr(self.instance, 'dataTermino', None))
        if inicio and termino and termino <= inicio:
            raise serializers.ValidationError(
                {'dataTermino': ['A data de término deve ser posterior à data de início.']})
        return super().validate(attrs)

    def get_quantidadeLocais(self, obj):
        return obj.bases.filter(is_active=True).count()

class ContatoInfoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = ContatoInfo
        fields = ['nome', 'endereco', 'whatsapp', 'email']

class ServicoEspecializadoInfoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = ServicoEspecializadoInfo
        fields = ['email', 'servicos_especializados', 'outras_informacoes']

class InfoGeraisSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = InfoGerais
        fields = ['razao_social', 'nome_fantasia', 'cnpj', 'endereco', 'telefone']

class EnderecoInfoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = EnderecoInfo
        fields = ['email', 'site', 'tipoImoveis', 'outrasInfo']

class LocadorasDeImoveisSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    contatos = InfoGeraisSerializer(many=True)  # Aninhando os dados completos
    servicos_especializados = EnderecoInfoSerializer(many=True)

    
    class Meta:
        model = LocadorasDeImoveis
        fields = [
            'id', 'pesquisa', 'contatos', 'servicos_especializados',
            'tipo_formulario', 'uf', 'regiao_turistica', 'municipio',
            'tipo', 'observacoes', 'referencias', 'usuario_criador',
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
    
class InformacoesGuiamentoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = InformacoesGuiamento
        fields = ['nome_completo', 'cpf', 'email', 'endereco', 'telefone']

class InformacoesGuiamentoCadasturSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = InformacoesGuiamentoCadastur
        fields = ['escolaridade', 'servicos_especializados_formulario', 'numero_cadastur', 'outras_informacoes', 'outros_cadastros']

class GuiamentoEConducaoTuristicaSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    contatos = InformacoesGuiamentoSerializer(many=True)  # Aninhando os dados completos
    servicos_especializados = InformacoesGuiamentoCadasturSerializer(many=True)

    
    class Meta:
        model = GuiamentoEConducaoTuristica
        fields = [
            'id', 'pesquisa', 'contatos', 'subtipos', 'servicos_especializados',
            'tipo_formulario', 'uf', 'regiao_turistica', 'municipio',
            'tipo', 'observacoes', 'referencias', 'usuario_criador',
            'nome_pesquisador', 'telefone_pesquisador', 'email_pesquisador',
            'nome_coordenador', 'telefone_coordenador', 'email_coordenador'
        ]

    def create(self, validated_data):
        contatos_data = validated_data.pop('contatos', [])
        servicos_data = validated_data.pop('servicos_especializados', [])
        
        sistema_de_seguranca = GuiamentoEConducaoTuristica.objects.create(**validated_data)
        
        for contato_data in contatos_data:
            contato = InformacoesGuiamento.objects.create(**contato_data)
            sistema_de_seguranca.contatos.add(contato)
        
        for servico_data in servicos_data:
            servico = InformacoesGuiamentoCadastur.objects.create(**servico_data)
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
        instance.subtipos = validated_data.get('subtipos', instance.subtipos)
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
                contato = InformacoesGuiamento.objects.create(**contato_data)
                instance.contatos.add(contato)
        
        if servicos_data is not None:
            instance.servicos_especializados.clear()
            for servico_data in servicos_data:
                servico = InformacoesGuiamentoCadastur.objects.create(**servico_data)
                instance.servicos_especializados.add(servico)
        
        return instance

class GastronomiaArtesanatoInfoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = GastronomiaArtesanatoInfo
        fields = ['nome_completo', 'atelie_aberto', 'email', 'endereco', 'telefone']

class GastronomiaArtesanatoInfoAtelieSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = GastronomiaArtesanatoInfoAtelie
        fields = ['ano_inicio_atividade', 'premiacao', 'outras_informacoes',]

class GastronomiaArtesanatoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    contatos = GastronomiaArtesanatoInfoSerializer(many=True)  # Aninhando os dados completos
    servicos_especializados = GastronomiaArtesanatoInfoAtelieSerializer(many=True)

    
    class Meta:
        model = GastronomiaArtesanato
        fields = [
            'id', 'pesquisa', 'contatos', 'subtipos', 'servicos_especializados',
            'tipo_formulario', 'uf', 'regiao_turistica', 'municipio',
            'tipo', 'observacoes', 'referencias', 'usuario_criador',
            'nome_pesquisador', 'telefone_pesquisador', 'email_pesquisador',
            'nome_coordenador', 'telefone_coordenador', 'email_coordenador',
            'nomeProduto', 'historicoProduto01', 'historicoProduto02', 'historicoProduto03',
            'historicoProduto04', 'modoPreparo01', 'modoPreparo02', 'modoPreparo03', 'modoPreparo04',
            'integraRoteiros', 'integraGuiaTuristico', 'roteiro1', 'siteRoteiro1',
            'roteiro2', 'siteRoteiro2', 'roteiro3', 'siteRoteiro3', 'roteiro4',
            'siteRoteiro4', 'roteiro5', 'siteRoteiro5', 'Guia1', 'siteGuia1',
            'Guia2', 'siteGuia2', 'Guia3', 'siteGuia3', 'Guia4', 'siteGuia4',
            'Guia5', 'siteGuia5', 'locaisDeComercializacao', 'descritivoEspecialidades',
            'tabelaEquipamentoEEspaco', 'tabelaEquipamentoEEspaco2', 'doEquipamentoEspaco', 'daAreaOuEdificacaoEmQueEstaLocalizado'
        ]

    def create(self, validated_data):
        contatos_data = validated_data.pop('contatos', [])
        servicos_data = validated_data.pop('servicos_especializados', [])
        
        sistema_de_seguranca = GastronomiaArtesanato.objects.create(**validated_data)
        
        for contato_data in contatos_data:
            contato = GastronomiaArtesanatoInfo.objects.create(**contato_data)
            sistema_de_seguranca.contatos.add(contato)
        
        for servico_data in servicos_data:
            servico = GastronomiaArtesanatoInfoAtelie.objects.create(**servico_data)
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
        instance.subtipos = validated_data.get('subtipos', instance.subtipos)
        instance.nomeProduto = validated_data.get('nomeProduto', instance.nomeProduto)
        instance.historicoProduto01 = validated_data.get('historicoProduto01', instance.historicoProduto01)
        instance.historicoProduto02 = validated_data.get('historicoProduto02', instance.historicoProduto02)
        instance.historicoProduto03 = validated_data.get('historicoProduto03', instance.historicoProduto03)
        instance.historicoProduto04 = validated_data.get('historicoProduto04', instance.historicoProduto04)
        instance.modoPreparo01 = validated_data.get('modoPreparo01', instance.modoPreparo01)
        instance.modoPreparo02 = validated_data.get('modoPreparo02', instance.modoPreparo02)
        instance.modoPreparo03 = validated_data.get('modoPreparo03', instance.modoPreparo03)
        instance.modoPreparo04 = validated_data.get('modoPreparo04', instance.modoPreparo04)
        instance.integraRoteiros = validated_data.get('integraRoteiros', instance.integraRoteiros)
        instance.integraGuiaTuristico = validated_data.get('integraGuiaTuristico', instance.integraGuiaTuristico)
        instance.roteiro1 = validated_data.get('roteiro1', instance.roteiro1)
        instance.siteRoteiro1 = validated_data.get('siteRoteiro1', instance.siteRoteiro1)
        instance.roteiro2 = validated_data.get('roteiro2', instance.roteiro2)
        instance.siteRoteiro2 = validated_data.get('siteRoteiro2', instance.siteRoteiro2)
        instance.roteiro3 = validated_data.get('roteiro3', instance.roteiro3)
        instance.siteRoteiro3 = validated_data.get('siteRoteiro3', instance.siteRoteiro3)
        instance.roteiro4 = validated_data.get('roteiro4', instance.roteiro4)
        instance.siteRoteiro4 = validated_data.get('siteRoteiro4', instance.siteRoteiro4)
        instance.roteiro5 = validated_data.get('roteiro5', instance.roteiro5)
        instance.siteRoteiro5 = validated_data.get('siteRoteiro5', instance.siteRoteiro5)
        instance.Guia1 = validated_data.get('Guia1', instance.Guia1)
        instance.siteGuia1 = validated_data.get('siteGuia1', instance.siteGuia1)
        instance.Guia2 = validated_data.get('Guia2', instance.Guia2)
        instance.siteGuia2 = validated_data.get('siteGuia2', instance.siteGuia2)
        instance.Guia3 = validated_data.get('Guia3', instance.Guia3)
        instance.siteGuia3 = validated_data.get('siteGuia3', instance.siteGuia3)
        instance.Guia4 = validated_data.get('Guia4', instance.Guia4)
        instance.siteGuia4 = validated_data.get('siteGuia4', instance.siteGuia4)
        instance.Guia5 = validated_data.get('Guia5', instance.Guia5)
        instance.siteGuia5 = validated_data.get('siteGuia5', instance.siteGuia5)
        instance.locaisDeComercializacao = validated_data.get('locaisDeComercializacao', instance.locaisDeComercializacao)
        instance.descritivoEspecialidades = validated_data.get('descritivoEspecialidades', instance.descritivoEspecialidades)
        instance.subtipos = validated_data.get('subtipos', instance.subtipos)
        instance.observacoes = validated_data.get('observacoes', instance.observacoes)
        instance.referencias = validated_data.get('referencias', instance.referencias)
        instance.nome_pesquisador = validated_data.get('nome_pesquisador', instance.nome_pesquisador)
        instance.telefone_pesquisador = validated_data.get('telefone_pesquisador', instance.telefone_pesquisador)
        instance.email_pesquisador = validated_data.get('email_pesquisador', instance.email_pesquisador)
        instance.nome_coordenador = validated_data.get('nome_coordenador', instance.nome_coordenador)
        instance.telefone_coordenador = validated_data.get('telefone_coordenador', instance.telefone_coordenador)
        instance.email_coordenador = validated_data.get('email_coordenador', instance.email_coordenador)
        instance.tabelaEquipamentoEEspaco = validated_data.get('tabelaEquipamentoEEspaco', instance.tabelaEquipamentoEEspaco)
        instance.tabelaEquipamentoEEspaco2 = validated_data.get('tabelaEquipamentoEEspaco2', instance.tabelaEquipamentoEEspaco2)
        instance.doEquipamentoEspaco= validated_data.get('doEquipamentoEspaco', instance.doEquipamentoEspaco)
        instance.daAreaOuEdificacaoEmQueEstaLocalizado = validated_data.get('daAreaOuEdificacaoEmQueEstaLocalizado', instance.daAreaOuEdificacaoEmQueEstaLocalizado)
        # Salva os campos principais atualizados
        instance.save()

        
        if contatos_data is not None:
            instance.contatos.clear()
            for contato_data in contatos_data:
                contato = GastronomiaArtesanatoInfo.objects.create(**contato_data)
                instance.contatos.add(contato)
        
        if servicos_data is not None:
            instance.servicos_especializados.clear()
            for servico_data in servicos_data:
                servico = GastronomiaArtesanatoInfoAtelie.objects.create(**servico_data)
                instance.servicos_especializados.add(servico)
        
        return instance



class SistemaDeSegurancaSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    contatos = ContatoInfoSerializer(many=True)  # Aninhando os dados completos
    servicos_especializados = ServicoEspecializadoInfoSerializer(many=True)

    
    class Meta:
        model = SistemaDeSeguranca
        fields = [
            'id', 'pesquisa', 'contatos', 'servicos_especializados',
            'tipo_formulario', 'uf', 'regiao_turistica', 'municipio',
            'tipo', 'observacoes', 'referencias', 'usuario_criador',
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

class RodoviaSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    # tipo_de_organizacao_instituicao = serializers.PrimaryKeyRelatedField(many=True, queryset=TipoOrganizacao.objects.all())
    # posto_de_combustivel = serializers.PrimaryKeyRelatedField(many=True, queryset=PostoDeCombustivel.objects.all())
    # outros_servicos = serializers.PrimaryKeyRelatedField(many=True, queryset=OutrosServicos.objects.all())
    # estruturas_ao_longo_da_vida = serializers.PrimaryKeyRelatedField(many=True, queryset=EstruturasAoLongoDaVia.objects.all())

    class Meta:
        model = Rodovia
        fields = '__all__'  # ou especifique os campos que você deseja incluir

class AlimentosEBebidasSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):

    class Meta:
        model = AlimentosEBebidas
        fields = '__all__'

class MeioDeHospedagemSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = MeioDeHospedagem
        fields = '__all__'

class OutrosMeiosDeHospedagemSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = OutrosMeiosDeHospedagem
        fields = '__all__'

class AgenciaDeTurismoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = AgenciaDeTurismo
        fields = '__all__'

class TransporteTuristicoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = TransporteTuristico
        fields = '__all__'
        
class ComercioTuristicoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = ComercioTuristico
        fields = '__all__'

class EspacoParaEventosSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = EspacoParaEventos
        fields = '__all__'
        
class ServicosParaEventosSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = ServicosParaEventos
        fields = '__all__'

class ParquesSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = Parques
        fields = '__all__'

class EspacosDeDiversaoECulturaSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = EspacosDeDiversaoECultura
        fields = '__all__'

class InformacoesTuristicasSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = InformacoesTuristicas
        fields = '__all__'
        
class EntidadesAssociativasSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = EntidadesAssociativas
        fields = '__all__'

class UnidadesDeConservacaoSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = UnidadesDeConservacao
        fields = '__all__'

class EventosProgramadosSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = EventosProgramados
        fields = '__all__'
        
class InformacoesBasicasSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = InformacaoBasicaDoMunicipio
        fields = '__all__'
        
class InstalacoesEsportivasSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = InstalacoesEsportivas
        fields = '__all__'

class EquipamentoSerializer(XSSSafeSerializerMixin, serializers.Serializer):
    tipo = serializers.CharField()
    dados = serializers.JSONField()

class DynamicBaseSerializer(XSSSafeSerializerMixin, serializers.ModelSerializer):

    class Meta:
        model = Base
        fields = '__all__'

# ---------------------------------------------------------------- Recuperação de senha
# Regras: a resposta não revela se o e-mail tem conta; o código de 6 dígitos vale 10 minutos e é anulado após
# 5 tentativas erradas na mesma conta (além do limite por IP nas views); a troca exige um código validado e
# ainda no prazo; a senha nova tem no mínimo 8 caracteres; as sessões abertas são encerradas após a troca.
OTP_MAX_FALHAS = 5
MENSAGEM_CODIGO_INVALIDO = 'Código inválido ou expirado. Peça um novo código.'


def _usuario_pelo_email(email):
    return CustomUser.objects.filter(email_hash=EncryptionService().get_email_index(email), is_active=True).first()


def _chave_falhas_otp(user):
    return f'otp-falhas:{user.id}'


class PasswordResetRequestSerializer(XSSSafeSerializerMixin, serializers.Serializer):
    email = serializers.EmailField()

    def validate_email(self, value):
        user = _usuario_pelo_email(value)
        # Sem conta: responde igual (não revela quais e-mails estão cadastrados), mas não envia nada
        if user is None:
            return value
        user.generate_otp()
        cache.delete(_chave_falhas_otp(user))
        send_mail(
            "Código para recuperar sua senha",
            f"Seu código para recuperar sua senha é: {user.otp}\n\n"
            "Ele vale por 10 minutos. Se você não pediu a recuperação, ignore este e-mail.",
            settings.DEFAULT_FROM_EMAIL,
            [user.email],
            fail_silently=False
        )
        return value


class OTPVerificationSerializer(XSSSafeSerializerMixin, serializers.Serializer):
    email = serializers.EmailField()
    otp = serializers.CharField(max_length=6)

    def validate(self, data):
        user = _usuario_pelo_email(data["email"])
        if user is None or not user.otp or not user.otp_exp or user.otp_exp < now():
            raise serializers.ValidationError({"otp": MENSAGEM_CODIGO_INVALIDO})

        if not hmac.compare_digest(str(user.otp), str(data["otp"]).strip()):
            chave = _chave_falhas_otp(user)
            cache.add(chave, 0, 15 * 60)
            try:
                falhas = cache.incr(chave)
            except ValueError:
                falhas = 1
                cache.set(chave, 1, 15 * 60)
            if falhas >= OTP_MAX_FALHAS:
                # Muitas tentativas: anula o código (é preciso pedir outro)
                user.otp, user.otp_exp, user.otp_verified = None, None, False
                user.save(update_fields=['otp', 'otp_exp', 'otp_verified'])
                cache.delete(chave)
            raise serializers.ValidationError({"otp": MENSAGEM_CODIGO_INVALIDO})

        cache.delete(_chave_falhas_otp(user))
        user.otp_verified = True
        user.save(update_fields=['otp_verified'])
        return data


class PasswordResetSerializer(XSSSafeSerializerMixin, serializers.Serializer):
    email = serializers.EmailField()
    new_password = serializers.CharField(write_only=True, min_length=8, error_messages={
        'min_length': 'A senha deve ter pelo menos 8 caracteres.'})

    def validate(self, data):
        user = _usuario_pelo_email(data["email"])
        # Código validado E ainda dentro dos 10 minutos (antes, a validação valia para sempre)
        if user is None or not user.otp_verified or not user.otp_exp or user.otp_exp < now():
            raise serializers.ValidationError({"otp": "Valide o código enviado por e-mail antes de trocar a senha."})
        self._user = user
        return data

    def save(self, **kwargs):
        from .retencao import _invalidar_sessoes
        user = self._user
        user.set_password(self.validated_data["new_password"])
        user.otp = None  # o código não pode ser reutilizado
        user.otp_exp = None
        user.otp_verified = False
        user.save()
        _invalidar_sessoes(user)  # quem estava logado com a senha antiga é desconectado
        return user
