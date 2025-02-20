from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator

 
def validate_cpf(cpf):
    cpf = ''.join(filter(str.isdigit, cpf))

    if len(cpf) != 11:
        raise ValidationError("O CPF deve ter 11 digítos")
    
    if cpf == cpf[0] * len(cpf):
        raise ValidationError("O CPF não pode ter todos os dígitos iguais")

    def calcular_digito(cpf, peso):
        soma = sum(int(d) * peso for d, peso in zip(cpf[:-2], range(peso, 1, -1)))
        resto = 11 - (soma % 11)
        return '0' if resto >= 10 else str(resto)
    
    digito1 = calcular_digito(cpf, 10)
    digito2 = calcular_digito(cpf + digito1, 11)

    if cpf[-2:] != digito1 + digito2:
        raise ValidationError("O CPF é inválido")
    
class CustomUser(AbstractUser):

    pesquisas = models.ManyToManyField("Pesquisa", related_name="pesquisas", blank=True)

    CPF = models.CharField(max_length=11, unique=True)
    username = models.CharField(
        max_length = 150,
        unique=True,
         validators=[
            RegexValidator(
                regex=r'^[\w\sáéíóúãõâêîôûçÁÉÍÓÚÃÕÂÊÎÔÛÇ]+$',
                message="O nome de usuário pode conter letras, números e espaços."
            )
        ],
    )
    acessLevel = models.CharField(max_length=22, default='Pesquisador');
    status = models.CharField(max_length=50, default='Ativo')
    
    def clean(self):
        super().clean()
        validate_cpf(self.CPF)
# Create your models here.



class Pesquisa(models.Model):

    usuario = models.ManyToManyField("CustomUser", related_name="usuario")
    admin = models.ForeignKey("CustomUser", on_delete=models.SET_NULL, null=True, blank=True, related_name="pesquisas_criadas", help_text="Administrador que criou esta pesquisa")
    

    criacao = models.DateField(auto_now_add=True)
    atualizacao = models.DateTimeField(auto_now = True)

    dataInicio = models.DateField()
    dataTermino = models.DateField()

    codigoIBGE = models.CharField(max_length=255)
    estado = models.CharField(max_length=255)
    municipio = models.CharField(max_length=255)

    status = models.CharField(max_length=50, default='Não Iniciado')
    

    is_active = models.BooleanField(default=True)


    @property
    def quantidadePesquisadores(self):
        return self.usuario.count()

    @property
    def quantidadeLocais(self):
        return self.bases.filter(is_active=True).count()


class Base(models.Model):
    
    pesquisa = models.ForeignKey(Pesquisa, on_delete=models.CASCADE, related_name="bases")
    
    is_active = models.BooleanField(default=True)
   
    tipo_formulario = models.CharField(max_length=100)
    uf = models.CharField(max_length=255)
    regiao_turistica = models.CharField(max_length=255)
    municipio = models.CharField(max_length=255)

    tipo = models.CharField(max_length=255)
  

    observacoes = models.TextField()
    referencias = models.TextField()

    nome_pesquisador = models.CharField(max_length=255)
    telefone_pesquisador = models.CharField(max_length=255)
    email_pesquisador = models.CharField(max_length=255)

    nome_coordenador = models.CharField(max_length=255)
    telefone_coordenador = models.CharField(max_length=255)
    email_coordenador = models.CharField(max_length=255)

class Inventariacao(models.Model):

    usuarios = models.ForeignKey(CustomUser, on_delete=models.CASCADE)

    equipamento = models.OneToOneField(Base, on_delete=models.SET_NULL, blank=True, null=True)

    criacao = models.DateField(auto_now_add=True)
    atualizacao = models.DateTimeField(auto_now = True)


class SistemaDeSeguranca(Base):
    contatos = models.ManyToManyField("ContatoInfo", related_name="sistemas_de_seguranca")
    servicos_especializados = models.ManyToManyField("ServicoEspecializadoInfo", related_name="sistemas_de_servicos_especializados")

class ContatoInfo(models.Model):

    sistema_de_seguranca = models.ManyToManyField("SistemaDeSeguranca", related_name="contatos_info")


    nome = models.CharField(max_length=255)
    endereco = models.CharField(max_length=255)
    whatsapp = models.CharField(max_length=255)
    email = models.CharField(max_length=255)

class ServicoEspecializadoInfo(models.Model):
    
    sistema_de_seguranca = models.ManyToManyField("SistemaDeSeguranca", related_name="servicos_info")


    email = models.CharField(max_length=255)
    servicos_especializados = models.TextField()
    outras_informacoes = models.TextField()
    

class AlimentosEBebidas(Base):

    razaoSocial = models.CharField(max_length=255)
    nomeFantasia = models.CharField(max_length=255)
    CNPJ = models.CharField(max_length=255)
    codigoCNAE = models.CharField(max_length=255)
    atividadeEconomica =models.CharField(max_length=255)
    inscricaoMunicipal = models.CharField(max_length=255)
    nomeDaRede =models.CharField(max_length=255)

    natureza = models.CharField(max_length=255)
    tipoDeOrganizacaoInstituicao = models.JSONField()
    inicioDaAtividade = models.DateField()
    qtdeFuncionariosPermanentes = models.CharField(max_length=255)
    qtdeFuncionariosTemporarios = models.CharField(max_length=255)
    qtdeFuncionariosComDeficiencia = models.CharField(max_length=255)
    localizacao = models.CharField(max_length=255)
    latitude = models.CharField(max_length=255)
    longitude =models.CharField(max_length=255)
    avenidaRuaEtc = models.CharField(max_length=255)
    bairroLocalidade = models.CharField(max_length=255)
    distrito = models.CharField(max_length=255)
    CEP = models.CharField(max_length=255)

    
    whatsapp = models.CharField(max_length=50)
    instagram = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    sinalizacaoDeAcesso = models.CharField(max_length=50)
    sinalizacaoTuristica = models.CharField(max_length=50)

    proximidades = models.JSONField()

    distanciasAeroporto = models.CharField(max_length=255)
    distanciasRodoviaria  = models.CharField(max_length=255)
    distanciaEstacaoFerroviaria  = models.CharField(max_length=255)
    distanciaEstacaoMaritima  = models.CharField(max_length=255)
    distanciaEstacaoMetroviaria  = models.CharField(max_length=255)
    distanciaPontoDeOnibus  = models.CharField(max_length=255)
    distanciaPontoDeTaxi  = models.CharField(max_length=255)
    distanciasOutraNome  = models.CharField(max_length=255)
    distanciaOutras  = models.CharField(max_length=255)

    pontosDeReferencia  = models.CharField(max_length=255)

    tabelaMTUR = models.JSONField()

    formasDePagamento = models.JSONField()
    vendasEReservas = models.JSONField()
    atendimentoEmLinguasEstrangeiras = models.JSONField()
    informativosImpressos = models.JSONField()

    periodo = models.JSONField()
    tabelasHorario = models.JSONField()

    funcionamento24h = models.CharField(max_length=255)
    funcionamentoEmFeriados = models.CharField(max_length=255)

    restricoes = models.JSONField()

    outrasRegraseInformacoes  = models.CharField(max_length=255)

    capInstaladaPdia  = models.CharField(max_length=255)
    capInstaladasSentadas  = models.CharField(max_length=255)
    capSimultanea  = models.CharField(max_length=255)
    capSimultaneaSentadas  = models.CharField(max_length=255)

    estacionamento = models.JSONField()

    capacidadeVeiculos  = models.CharField(max_length=255)

    numeroAutomoveis  = models.CharField(max_length=255)

    numeroOnibus  = models.CharField(max_length=255)

    servicosEEquipamentos = models.JSONField()

    especificacaoDaGastronomiaPorPais = models.JSONField()

    seForBrasileiraPorRegiao = models.JSONField()
    porEspecializacao = models.JSONField()
    porTipoDeDieta = models.JSONField()
    porTipoDeServico = models.JSONField()

    doEquipamento = models.CharField(max_length=255)

    tabelaEquipamentoEEspaco = models.JSONField()

    estadoGeralDeConservacao = models.CharField(max_length=255)

    possuiFacilidade = models.CharField(max_length=255)

    pessoalCapacitadoParaReceberPCD = models.JSONField()

    rotaExternaAcessível  = models.JSONField()

    simboloInternacionalDeAcesso  = models.JSONField()

    localDeEmbarqueEDesembarque  = models.JSONField()

    vagaEmEstacionamento  = models.JSONField()

    areaDeCirculacaoAcessoInternoParaCadeiraDeRodas  = models.JSONField()

    escada  = models.JSONField()

    rampa  = models.JSONField()

    piso  = models.JSONField()

    elevador =  models.JSONField()

    equipamentoMotorizadoParaDeslocamentoInterno = models.JSONField()

    sinalizacaoVisual = models.JSONField()

    sinalizacaoTatil = models.JSONField()

    alarmeDeEmergencia = models.JSONField()

    comunicacao = models.JSONField()

    balcaoDeAtendimento = models.JSONField()

    mobiliario = models.JSONField()

    sanitario = models.JSONField()

    telefone = models.JSONField()

    sinalizacaoIndicativa = models.CharField(max_length=255)

    outrosAcessibilidade = models.CharField(max_length=255)
    

class Rodovia(Base):

    subtipos = models.CharField(max_length=255)

    nome_oficial = models.CharField(max_length=255)
    nome_popular = models.CharField(max_length=255)

    jurisdicao = models.CharField(max_length=50)
    natureza = models.CharField(max_length=50)
    
    tipo_de_organizacao_instituicao = models.JSONField()
    

    extensao_rodovia_municipio = models.DecimalField(max_digits=10, decimal_places=2)

    faixas_de_rolamento = models.CharField(max_length=50)

    pavimentacao = models.CharField(max_length=50)

    pedagio = models.CharField(max_length=10)

    municipios_vizinhos_interligados_rodovia = models.TextField()

    inicio_atividade = models.DateField()

    ##Entidade mantedora

    whatsapp = models.CharField(max_length=50)
    instagram = models.CharField(max_length=50)

    ##Sinalização

    sinalizacao_de_acesso = models.CharField(max_length=10)
    sinalizacao_turistica = models.CharField(max_length=10)

    ##Características

    posto_de_combustivel = models.JSONField()
    outros_servicos = models.JSONField()
    estruturas_ao_longo_da_via = models.JSONField()

    ##Questões ambientais/Sociais

    poluicao = models.CharField(max_length=10)
    poluicao_especificacao = models.TextField()

    lixo = models.CharField(max_length=10)
    lixo_especificacao = models.TextField()

    desmatamento = models.CharField(max_length=10)
    desmatamento_especificacao = models.TextField()

    queimadas = models.CharField(max_length=10)
    queimadas_especificacao = models.TextField()

    inseguranca = models.CharField(max_length=10)
    inseguranca_especificacao = models.TextField()

    extrativismo = models.CharField(max_length=10)
    extrativismo_especificacao = models.TextField()

    prostituicao = models.CharField(max_length=10)
    prostituicao_especificacao = models.TextField()

    ocupacao_irregular_invasao = models.CharField(max_length=10)
    ocupacao_irregular_invasao_especificacao = models.TextField()

    outras = models.CharField(max_length=10)
    outras_especificacao = models.TextField()

    ##Estado geral de conservação

    estado_geral_de_conservacao = models.CharField(max_length=20)

    ##Observações

