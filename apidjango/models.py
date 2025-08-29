from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator
import uuid 
from django.utils import timezone
from datetime import timedelta 
from django.core.mail import send_mail, EmailMessage
import random
from datetime import timedelta
from django.utils import timezone



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

    pesquisas = models.ManyToManyField("Pesquisa", related_name="pesquisas", blank=True, null=True)
    email = models.EmailField(unique=True)
    CPF = models.CharField(max_length=11, unique=True)
    username = models.CharField(
        max_length = 150,
        unique=False,
         validators=[
            RegexValidator(
                regex=r'^[\w\sáéíóúãõâêîôûçÁÉÍÓÚÃÕÂÊÎÔÛÇ]+$',
                message="O nome de usuário pode conter letras, números e espaços."
            )
        ],
    )

    otp = models.CharField(max_length=6, blank=True, null=True)
    otp_exp = models.DateTimeField(blank=True, null=True)
    otp_verified = models.BooleanField(default=False)

    def generate_otp(self):
        self.otp = str(random.randint(100000, 999999))
        self.otp_exp = timezone.now() + timedelta(minutes=10)
        self.otp_verified = False
        self.save()

    acessLevel = models.CharField(max_length=22, default='Pesquisador');
    status = models.CharField(max_length=50, default='Ativo');
    telefone = models.CharField(max_length=25);
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
    def admin_email(self):
        return self.admin.email if self.admin else None
    
    @property
    def admin_telefone(self):
        return self.admin.telefone if self.admin else None

    @property
    def quantidadePesquisadores(self):
        return self.usuario.count()

    @property
    def quantidadeLocais(self):
        return self.bases.filter(is_active=True).count()


class Base(models.Model):
    
    pesquisa = models.ForeignKey(Pesquisa, on_delete=models.CASCADE, related_name="bases")
    
    is_active = models.BooleanField(default=True)
   
    tipo_formulario = models.CharField(max_length=100, blank=True, null=True)
    uf = models.CharField(max_length=255, blank=True, null=True)
    regiao_turistica = models.CharField(max_length=255, blank=True, null=True)
    municipio = models.CharField(max_length=255, blank=True, null=True)

    tipo = models.CharField(max_length=255, blank=True, null=True)
  
 
    observacoes = models.TextField(blank=True, null=True)
    referencias = models.TextField(blank=True, null=True)

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


    nome = models.CharField(max_length=255,null=True, blank=True)
    endereco = models.CharField(max_length=255,null=True, blank=True)
    whatsapp = models.CharField(max_length=255,null=True, blank=True)
    email = models.CharField(max_length=255,null=True, blank=True)

class ServicoEspecializadoInfo(models.Model):
    
    sistema_de_seguranca = models.ManyToManyField("SistemaDeSeguranca", related_name="servicos_info")


    email = models.CharField(max_length=255,null=True, blank=True)
    servicos_especializados = models.TextField(null=True, blank=True)
    outras_informacoes = models.TextField(null=True, blank=True)
    

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

    tabelaMTUR = models.JSONField(null=True, blank=True)

    formasDePagamento = models.JSONField()
    vendasEReservas = models.JSONField()
    atendimentoEmLinguasEstrangeiras = models.JSONField()
    informativosImpressos = models.JSONField()

    periodo = models.JSONField()
    tabelasHorario = models.JSONField(null=True, blank=True)

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

    tabelaEquipamentoEEspaco = models.JSONField(null=True, blank=True)

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

class MeioDeHospedagem(Base):
   
    # Dados do formulário e pesquisador
    
    # Dados do coordenador
    
    # Sinalizações e funcionamento
    sinalizacaoDeAcesso = models.CharField("Sinalização de Acesso",max_length=255)
    sinalizacaoTuristica = models.CharField("Sinalização Turística",max_length=255)
    funcionamento24h = models.CharField("Funcionamento 24h",max_length=255)
    funcionamentoEmFeriados = models.CharField("Funcionamento em Feriados",max_length=255)
    geradorDeEmergencia = models.CharField("Gerador de Emergência",max_length=255)
    
    # Infraestrutura e localização do equipamento/edificação
    doEquipamentoEspaco = models.TextField("Do Equipamento/Espaço", blank=True, null=True)
    daAreaOuEdificacaoEmQueEstaLocalizado = models.TextField("Da Área/Edificação em que Está Localizado", blank=True, null=True)
    possuiFacilidade = models.CharField("Possui Facilidade",max_length=255,)
    sinalizacaoIndicativa = models.CharField("Sinalização Indicativa", max_length=255)
    tipoDeOrganizacao = models.JSONField("Tipo de Organização")
    proximidades = models.JSONField("Proximidades")
    
    # Dados relacionados ao turismo e pagamentos
    segmentosOuTurismoEspecializado = models.JSONField("Segmentos ou Turismo Especializado")
    formasDePagamento = models.JSONField("Formas de Pagamento")
    reservas = models.JSONField("Reservas")
    atendimentoEmLinguaEstrangeira = models.JSONField("Atendimento em Língua Estrangeira")
    informativosImpressos = models.JSONField("Informativos Impressos",)
    restricoes = models.JSONField("Restrições")
    mesesAltaTemporada = models.JSONField("Meses de Alta Temporada")
    origemDosVisitantes = models.JSONField("Origem dos Visitantes",)
    
    # Produtos e serviços
    produtosHigienePessoal = models.JSONField("Produtos de Higiene Pessoal")
    equipamentosEServicos = models.JSONField("Equipamentos e Serviços")
    estacionamento = models.JSONField("Estacionamento")
    restaurante = models.JSONField("Restaurante",)
    lanchonete = models.JSONField("Lanchonete",)
    instalacaoEEspacos = models.JSONField("Instalação e Espaços")
    outrosEspacosEAtividades = models.JSONField("Outros Espaços e Atividades")
    servicos = models.JSONField("Serviços")
    equipamentos = models.JSONField("Equipamentos")
    facilidadesEServicos = models.JSONField("Facilidades e Serviços")
    facilidadesParaExecutivos = models.JSONField("Facilidades para Executivos")
    pessoalCapacitadoParaReceberPCD = models.JSONField("Pessoal Capacitado para Receber PCD")
    
    # Acessibilidade
    rotaExternaAcessivel = models.JSONField("Rota Externa Acessível")
    simboloInternacionalDeAcesso = models.JSONField("Símbolo Internacional de Acesso")
    localDeEmbarqueEDesembarque = models.JSONField("Local de Embarque e Desembarque")
    vagaEmEstacionamento = models.JSONField("Vaga em Estacionamento")
    areaDeCirculacaoAcessoInterno = models.JSONField("Área de Circulação/Acesso Interno")
    escada = models.JSONField("Escada")
    rampa = models.JSONField("Rampa",)
    piso = models.JSONField("Piso")
    elevador = models.JSONField("Elevador",)
    equipamentoMotorizadoParaDeslocamentoInterno = models.JSONField("Equipamento Motorizado para Deslocamento Interno")
    sinalizacaoVisual = models.JSONField("Sinalização Visual")
    sinalizacaoTatil = models.JSONField("Sinalização Tátil")
    alarmeDeEmergencia = models.JSONField("Alarme de Emergência")
    comunicacao = models.JSONField("Comunicação")
    balcaoDeAtendimento = models.JSONField("Balcão de Atendimento")
    mobiliario = models.JSONField("Mobiliário",)
    sanitario = models.JSONField("Sanitário")
    telefone = models.JSONField("Telefone")
    
    # Classificação e localização do meio de hospedagem
    subtipo = models.JSONField(blank=True, null=True)
    natureza = models.CharField("Natureza", max_length=255, blank=True, null=True)
    localizacao = models.TextField("Localização", blank=True, null=True)
    tipoDeDiaria = models.CharField("Tipo de Diária", max_length=255, blank=True, null=True)
    periodo = models.JSONField(blank=True, null=True)
    tabelasHorario = models.JSONField("Tabelas de Horário",blank=True,null=True)
    energiaEletrica = models.TextField("Energia Elétrica", blank=True, null=True)
    estadoGeralDeConservacao = models.CharField("Estado Geral de Conservação", max_length=255, blank=True, null=True)
    
    # Dados de turismo e localização geográfica
    estadosTuristas = models.JSONField("Estados Turistas", blank=True, null=True)
    paisesTuristas = models.JSONField("Países Turistas", blank=True,null=True)
    
    # Dados empresariais
    razaoSocial = models.CharField("Razão Social", max_length=255, blank=True, null=True)
    nomeFantasia = models.CharField("Nome Fantasia", max_length=255, blank=True, null=True)
    codigoCNAE = models.CharField("Código CNAE", max_length=50, blank=True, null=True)
    atividadeEconomica = models.TextField("Atividade Econômica", blank=True, null=True)
    inscricaoMunicipal = models.CharField("Inscrição Municipal", max_length=50, blank=True, null=True)
    nomeDaRede = models.CharField("Nome da Rede", max_length=255, blank=True, null=True)
    CNPJ = models.CharField("CNPJ", max_length=20, blank=True, null=True)
    inicioDaAtividade = models.DateField("Início da Atividade", blank=True, null=True)
    
    # Dados de quantitativos e capacidade
    qtdeFuncionariosPermanentes = models.IntegerField("Qtd. Funcionários Permanentes", default=0)
    qtdeFuncionariosTemporarios = models.IntegerField("Qtd. Funcionários Temporários", default=0)
    qtdeFuncionarisComDeficiencia = models.IntegerField("Qtd. Funcionários com Deficiência", default=0)
    latitude = models.CharField(max_length=255)
    longitute = models.CharField(max_length=255)
    
    # Endereço e contato
    avenidaRuaEtc = models.CharField("Avenida/Rua/etc.", max_length=255, blank=True, null=True)
    bairroLocalidade = models.CharField("Bairro/Localidade", max_length=255, blank=True, null=True)
    distrito = models.CharField("Distrito", max_length=255, blank=True, null=True)
    CEP = models.CharField("CEP", max_length=20, blank=True, null=True)
    whatsapp = models.CharField("WhatsApp", max_length=50, blank=True, null=True)
    instagram = models.CharField("Instagram", max_length=100, blank=True, null=True)
    email = models.EmailField("Email", max_length=254, blank=True, null=True)
    site = models.CharField("Site", max_length=255)
    pontosDeReferencia = models.TextField("Pontos de Referência", blank=True, null=True)
    
    # Dados de tabelas e informações adicionais
    tabelaMTUR = models.JSONField("Tabela MTUR",blank=True,null=True)
    outrasRegrasEInformacoes = models.TextField("Outras Regras e Informações", blank=True, null=True)
    nAnoOcupacao = models.CharField("Ano de Ocupação", max_length=255)
    nOcupacaoAltaTemporada = models.CharField("Ocupação em Alta Temporada", max_length=255)
    nTotalDeUH = models.IntegerField("Total de UH", default=0)
    nTotalDeLeitos = models.IntegerField("Total de Leitos", default=0)
    nUhAdaptadasParaPCD = models.IntegerField("UH Adaptadas para PCD", default=0)
    nCapacidadeDeVeiculos = models.IntegerField("Capacidade de Veículos", default=0)
    nAutomoveis = models.IntegerField("Número de Automóveis", default=0)
    nOnibus = models.IntegerField("Número de Ônibus", default=0)
    capacidadeEmKVA = models.DecimalField("Capacidade (KVA)", max_digits=10, decimal_places=2, blank=True, null=True)
    geradorCapacidadeEmKVA = models.DecimalField("Capacidade do Gerador (KVA)", max_digits=10, decimal_places=2, blank=True, null=True)
    nCapacidadeInstaladaPorDia = models.IntegerField("Capacidade Instalada por Dia", default=0)
    nPessoasAtendidasSentadas = models.IntegerField("Qtd. de Pessoas Atendidas Sentadas", default=0)
    nCapacidadeSimultanea = models.IntegerField("Capacidade Simultânea", default=0)
    nPessoasAtendidasSentadasSimultanea = models.IntegerField("Qtd. de Pessoas Atendidas Sentadas (Simultânea)", default=0)
    lanchoneteCapacidadeInstaladaPorDia = models.IntegerField("Lanchonete - Capacidade Instalada por Dia", default=0)
    lanchoneteCapacidadePessoasAtendidasSentadas = models.IntegerField("Lanchonete - Pessoas Atendidas Sentadas", default=0)
    lanchoneteCapacidadeSimultanea = models.IntegerField("Lanchonete - Capacidade Simultânea", default=0)
    lanchoneteCapacidadeSentadasSimultanea = models.IntegerField("Lanchonete - Pessoas Sentadas Simultânea", default=0)
    
    # Tabelas de instalações e equipamentos/espaços
    tabelaInstalacoes = models.JSONField("Tabela Instalações",blank=True,null=True)
    tabelaEquipamentoEEspaco = models.JSONField("Tabela Equipamento e Espaço",blank=True,null=True)
    tabelaEquipamentoEEspaco2 = models.JSONField("Tabela Equipamento e Espaço 2",blank=True,null=True )
    
    # Observações e referências
    outros = models.TextField("Outros", blank=True, null=True)

class InformacaoBasicaDoMunicipio(Base):
    
    enderecoPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    bairroPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    cepPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    numeroPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    instagramPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    emailPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    sitePrefeitura = models.CharField(max_length=255,blank=True, null=True)
    cnpjPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    latitudePrefeitura = models.CharField(max_length=255,blank=True, null=True)
    longitudePrefeitura = models.CharField(max_length=255,blank=True, null=True)
    municipiosLimitrofes = models.CharField(max_length=255,blank=True, null=True)
    distanciaDaCapital = models.CharField(max_length=255,blank=True, null=True)
    totalFuncionariosPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    pessoasComDeficienciaPrefeitura = models.CharField(max_length=255,blank=True, null=True)
    nomeDoPrefeito = models.CharField(max_length=255,blank=True, null=True)
    nomeDasSecretariasEtc = models.CharField(max_length=255,blank=True, null=True)
    nomeOrgaoOficialTurismo = models.CharField(max_length=255,blank=True, null=True)
    enderecoOrgaoOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    avenidaRuaOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    distritoOrgaoOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    cepOrgaoOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    numeroOrgaoOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    instagramOrgaoOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    siteOrgaoOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    emailOrgaoOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    qtdeFuncionariosOrgaoOfcTurismo = models.CharField(max_length=255,blank=True, null=True)
    qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo = models.CharField(max_length=255,blank=True, null=True)
    instanciaGovernancaMunicipal = models.CharField(max_length=255,blank=True, null=True)
    instanciaGovernancaEstadual = models.CharField(max_length=255,blank=True, null=True)
    instanciaGovernancaRegional = models.CharField(max_length=255,blank=True, null=True)
    instanciaGovernancaNacional = models.CharField(max_length=255,blank=True, null=True)
    instanciaGovernancaInternacional = models.CharField(max_length=255,blank=True, null=True)
    instanciaGovernancaOutras = models.CharField(max_length=255,blank=True, null=True)
    aniversarioMunicipio = models.CharField(max_length=255,blank=True, null=True)
    santoPadroeiro = models.CharField(max_length=255,blank=True, null=True)
    diaDoSantoPadroeiro = models.CharField(max_length=255,blank=True, null=True)
    feriadoMunicipal01 = models.CharField(max_length=255,blank=True, null=True)
    dataFeriadoMunicipal01 = models.CharField(max_length=255,blank=True, null=True)
    feriadoMunicipal02 = models.CharField(max_length=255,blank=True, null=True)
    dataFeriadoMunicipal02 = models.CharField(max_length=255,blank=True, null=True)
    feriadoMunicipal03 = models.CharField(max_length=255,blank=True, null=True)
    dataFeriadoMunicipal03 =models.CharField(max_length=255,blank=True, null=True)
    origemDoNome =models.CharField(max_length=255,blank=True, null=True)
    dataFundacao = models.CharField(max_length=255,blank=True, null=True)
    dataEmancipacao = models.CharField(max_length=255,blank=True, null=True)
    fundadores = models.CharField(max_length=255,blank=True, null=True)
    outrosFatosDeImportanciaHistorica = models.CharField(max_length=255,blank=True, null=True)

    areaTotalMunicipio = models.CharField(max_length=255,blank=True, null=True)
    areaUrbana = models.CharField(max_length=255,blank=True, null=True)
    areaRural = models.CharField(max_length=255,blank=True, null=True)
    anoBase = models.CharField(max_length=255,blank=True, null=True)
    populacaoTotal = models.CharField(max_length=255,blank=True, null=True)
    populacaoUrbana = models.CharField(max_length=255,blank=True, null=True)
    populacaoRural = models.CharField(max_length=255,blank=True, null=True)
    anoBasePopulacao = models.CharField(max_length=255,blank=True, null=True)
    temperaturaMedia = models.CharField(max_length=255,blank=True, null=True)
    temperaturaMinima = models.CharField(max_length=255,blank=True, null=True)
    temperaturaMaxima = models.CharField(max_length=255,blank=True, null=True)
    altitudeMedia = models.CharField(max_length=255,blank=True, null=True)
    qtdeDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    empresaResponsavel = models.CharField(max_length=255,blank=True, null=True)
    esgotoTotalAtendidos = models.CharField(max_length=255,blank=True, null=True)
    esgotoDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    esgotoRuraisAtendidos = models.CharField(max_length=255,blank=True, null=True)
    esgotoEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    fossaSepticaTotalAtendidos = models.CharField(max_length=255,blank=True, null=True)
    fossaSepticaDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    fossaSepticaRuraisAtendidos = models.CharField(max_length=255,blank=True, null=True)
    fossaSepticaEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    fossaRudimentarTotalAtendidos = models.CharField(max_length=255,blank=True, null=True)
    fossaRudimentarDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    fossaRudimentarRuraisAtendidos = models.CharField(max_length=255,blank=True, null=True)
    fossaRudimentarEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    valaTotalAtendidos = models.CharField(max_length=255,blank=True, null=True)
    valaDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    valaRuraisAtendidos = models.CharField(max_length=255,blank=True, null=True)
    valaEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    estacaoDeTratamentoTotalAtendidos = models.CharField(max_length=255,blank=True, null=True)
    estacaoDeTratamentoDomiciliosAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    estacaoDeTratamentoRuraisAtendidos = models.CharField(max_length=255,blank=True, null=True)
    estacaoDeTratamentoEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    esgotoTratadoTotalAtendidos = models.CharField(max_length=255,blank=True, null=True)
    esgotoTratadoDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    esgotoTratadoRuraisAtendidos = models.CharField(max_length=255,blank=True, null=True)
    esgotoTratadoEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    servicoDeEsgotoOutroTotalNome = models.CharField(max_length=255,blank=True, null=True)
    servicoDeEsgotoOutroTotalAtendidos = models.CharField(max_length=255,blank=True, null=True)
    servicoDeEsgotoOutroDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    servicoDeEsgotoOutroRuraisAtendidos = models.CharField(max_length=255,blank=True, null=True)
    servicoDeEsgotoOutroEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    capacidadeEmKVA = models.CharField(max_length=255,blank=True, null=True)
    geradorDeEmergenciaCapacidadeEmKVA = models.CharField(max_length=255,blank=True, null=True)
    redeUrbanaTotalAbastecido = models.CharField(max_length=255,blank=True, null=True)
    redeUrbanaEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    redeRuralTotalAbastecido  = models.CharField(max_length=255,blank=True, null=True)
    redeRuralEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    abastecimentoProprioTotalAtendidos = models.CharField(max_length=255,blank=True, null=True)
    abastecimentoProprioDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    abastecimentoProprioRuraisAtendidos = models.CharField(max_length=255,blank=True, null=True)
    abastecimentoProprioEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)

    servicosDeEnergiaOutroTotalNome = models.CharField(max_length=255,blank=True, null=True)
    servicosDeEnergiaOutroTotalAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    servicosDeEnergiaOutroDomiciliosAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    servicosDeEnergiaOutroEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    coletaSeletivaTotalAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    coletaSeletivaDomiciliosAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    coletaSeletivaRuraisAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    coletaSeletivaEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    coletaNaoSeletivaTotalAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    coletaNaoSeletivaDomiciliosAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    coletaNaoSeletivaRuraisAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    coletaNaoSeletivaEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    coletaSemColetaTotal  = models.CharField(max_length=255,blank=True, null=True)
    coletaSemColetaDomicilios  = models.CharField(max_length=255,blank=True, null=True)
    coletaSemColetaRurais  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoAterroSanitarioTotalAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoAterroSanitarioDomiciliosAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoAterroSanitarioRuraisAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoAterroSanitarioEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoACeuAbertoTotalAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoACeuAbertoDomiciliosAtendidos = models.CharField(max_length=255,blank=True, null=True)
    deposicaoACeuAbertoRuraisAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoACeuAbertoEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoOutroTotalNome  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoOutroTotalAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoOutroDomiciliosAtendidos  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoOutroEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeAcoTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeAcoEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeAluminioTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeAluminioEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeFerroTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeFerroEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemOutroNome  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemOutroTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemOutroEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeBateriasPilhasTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeBateriasPilhasEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeBorrachaTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeBorrachaEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEletronicosTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEletronicosEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEmbalagensLongaVidaTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEmbalagensLongaVidaEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEntulhoTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEntulhoEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeMadeiraTotalReciclado = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeMadeiraEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDePapelTotalReciclado = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDePapelEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDePlasticoEEmbalagensTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDePlasticoEEmbalagensEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeVidroTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeVidroEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeOleoDeCozinhaTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeOleoDeCozinhaEntidadeResponsavel = models.CharField(max_length=255,blank=True, null=True)
    reciclagemOutrosNome  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemOutrosTotalReciclado  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemOutrosEntidadeResponsavel  = models.CharField(max_length=255,blank=True, null=True)
    divulgacaoImpressaFolder  = models.CharField(max_length=255,blank=True, null=True)
    divulgacaoImpressaRevista  = models.CharField(max_length=255,blank=True, null=True)
    divulgacaoImpressaJornal  = models.CharField(max_length=255,blank=True, null=True)
    divulgacaoImpressaOutros  = models.CharField(max_length=255,blank=True, null=True)
    visitantesAno  = models.CharField(max_length=255,blank=True, null=True)
    visitantesAnoAltaTemporada  = models.CharField(max_length=255,blank=True, null=True)
    origemInternacionalAnoBase  = models.CharField(max_length=255,blank=True, null=True)
    atrativosMaisVisitados = models.CharField(max_length=255,blank=True, null=True)
    redeDeEsgoto = models.CharField(max_length=255,blank=True, null=True)
    fossaSeptica  = models.CharField(max_length=255,blank=True, null=True)
    fossaRudimentar  = models.CharField(max_length=255,blank=True, null=True)
    vala  = models.CharField(max_length=255,blank=True, null=True)
    estacaoDeTratamento = models.CharField(max_length=255,blank=True, null=True)
    esgotoTratado  = models.CharField(max_length=255,blank=True, null=True)
    servicoDeEsgotoOutros = models.CharField(max_length=255,blank=True, null=True)
    geradorDeEmergencia  = models.CharField(max_length=255,blank=True, null=True)
    redeUrbana  = models.CharField(max_length=255,blank=True, null=True)
    redeRural  = models.CharField(max_length=255,blank=True, null=True)
    abastecimentoProprio = models.CharField(max_length=255,blank=True, null=True)
    servicosDeEnergiaOutro = models.CharField(max_length=255,blank=True, null=True)
    coletaSeletiva = models.CharField(max_length=255,blank=True, null=True)
    coletaNaoSeletiva = models.CharField(max_length=255,blank=True, null=True)
    coletaSemColeta  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoAterroSanitario = models.CharField(max_length=255,blank=True, null=True)
    deposicaoCompostagem  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoACeuAberto  = models.CharField(max_length=255,blank=True, null=True)
    deposicaoOutro  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeAco  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeAluminio = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeFerro  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemOutro  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeBateriasPilhas = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeBorracha  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEletronicos = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEmbalagensLongaVida = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeEntulho  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeMadeira  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDePapel  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDePlasticoEEmbalagens = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeVidro = models.CharField(max_length=255,blank=True, null=True)
    reciclagemDeOleoDeCozinha  = models.CharField(max_length=255,blank=True, null=True)
    reciclagemOutros  = models.CharField(max_length=255,blank=True, null=True)
    servicosDeComunicacaoTelefoniaMovel  = models.CharField(max_length=255,blank=True, null=True)
    servicosDeComunicacaoTelefoniaFixa  = models.CharField(max_length=255,blank=True, null=True)
    promocaoTuristicaDivulgacaoImpressa  = models.CharField(max_length=255,blank=True, null=True)
    promocaoTuristicaDivulgacaoTelevisiva  = models.CharField(max_length=255,blank=True, null=True)
    mesesMaisFrios = models.JSONField(blank=True, null=True)
    mesesMaisQuentes  = models.JSONField(blank=True, null=True)
    mesesMaisChuvosos  = models.JSONField(blank=True, null=True)
    mesesMenosChuvosos  = models.JSONField(blank=True, null=True)
    tipoDeAbastecimento  = models.CharField(max_length=255,blank=True, null=True)
    energiaEletrica  = models.CharField(max_length=255,blank=True, null=True)
    servicosDeComunicacaoAcessoAInternet  = models.CharField(max_length=255,blank=True, null=True)
    telefoniaFixaAreaDeCobertura = models.CharField(max_length=255,blank=True, null=True)
    telefoniaMovelAreaDeCobertura = models.CharField(max_length=255,blank=True, null=True)
    atendimentoEmLinguaEstrangeira  = models.CharField(max_length=255,blank=True, null=True)
    atendimentoAoVisitanteInformativosImpressos  = models.CharField(max_length=255,blank=True, null=True)
    mesesAltaTemporada  = models.JSONField(blank=True, null=True)
    origemDosVisitantesTuristas  = models.JSONField(blank=True, null=True)
    origemNacional  = models.JSONField(blank=True, null=True)
    origemInternacional  = models.JSONField(blank=True, null=True)
    segmentosTurismoEspecializado  = models.JSONField(blank=True, null=True)
    leiOrganica   = models.CharField(max_length=255,blank=True, null=True)
    ocupacaoDoSolo  = models.CharField(max_length=255,blank=True, null=True)
    planoDeDesenvolvimentoDoTurismo   = models.CharField(max_length=255,blank=True, null=True)
    protecaoAmbiental  = models.CharField(max_length=255,blank=True, null=True)
    apoioACultura   = models.CharField(max_length=255,blank=True, null=True)
    incentivosFiscaisAoTurismo   = models.CharField(max_length=255,blank=True, null=True)
    planoDiretor = models.CharField(max_length=255,blank=True, null=True)
    fundoMunicipalDeTurismo  = models.CharField(max_length=255,blank=True, null=True)
    legislacaoOutras  = models.CharField(max_length=255,blank=True, null=True)


class ComercioTuristico(Base):
     sinalizacaoDeAcesso =  models.CharField(max_length=255,blank=True, null=True)
     sinalizacaoTuristica = models.CharField(max_length=255,blank=True, null=True)
     subtipo =  models.JSONField(blank=True, null=True) 
     natureza =  models.CharField(max_length=255,blank=True, null=True) 
     tipoDeOrganizacao =  models.CharField(max_length=255,blank=True, null=True) 
     localizacao =  models.CharField(max_length=255,blank=True, null=True) 
     razaoSocial = models.CharField(max_length=255,blank=True, null=True)  
     nomeFantasia = models.CharField(max_length=255,blank=True, null=True)  
     CNPJ =  models.CharField(max_length=255,blank=True, null=True) 
     codigoCNAE =  models.CharField(max_length=255,blank=True, null=True) 
     atividadeEconomica = models.CharField(max_length=255,blank=True, null=True)  
     inscricaoMunicipal =  models.CharField(max_length=255,blank=True, null=True) 
     nomeDaRedeFranquia =  models.CharField(max_length=255,blank=True, null=True) 
     longitudePrefeitura =  models.CharField(max_length=255,blank=True, null=True) 
     latitudePrefeitura =  models.CharField(max_length=255,blank=True, null=True) 
     avenidaRuaTravessa =  models.CharField(max_length=255,blank=True, null=True) 
     bairroLocalidade =   models.CharField(max_length=255,blank=True, null=True)
     distrito =   models.CharField(max_length=255,blank=True, null=True)
     CEP =   models.CharField(max_length=255,blank=True, null=True)
     whatsapp =   models.CharField(max_length=255,blank=True, null=True)
     instagram =   models.CharField(max_length=255,blank=True, null=True)
     email =   models.CharField(max_length=255,blank=True, null=True)
     site =   models.CharField(max_length=255,blank=True, null=True)
     pontosDeReferencia =   models.CharField(max_length=255,blank=True, null=True)
     outrasRegrasEInformacoes = models.CharField(max_length=255,blank=True, null=True)  
     capacidadeDeVeiculos =   models.CharField(max_length=255,blank=True, null=True)
     automoveis =   models.CharField(max_length=255,blank=True, null=True)
     onibus =   models.CharField(max_length=255,blank=True, null=True)
     outrasAcessibilidade = models.CharField(max_length=255,blank=True, null=True)
     funcionamento24h =  models.CharField(max_length=255,blank=True, null=True)
     funcionamentoEmFeriados =  models.CharField(max_length=255,blank=True, null=True)
     formasDePagamento =  models.JSONField(blank=True, null=True)
     atendimentoEmLinguaEstrangeira =   models.CharField(max_length=255,blank=True, null=True)
     informativosImpressos = models.JSONField(blank=True, null=True)
     regrasDeFuncionamentoPeriodo =   models.JSONField(blank=True, null=True)
     estacionamento =   models.CharField(max_length=255,blank=True, null=True)
     produtosEServicos =   models.JSONField(blank=True, null=True)
     outrosServicos =   models.JSONField(blank=True, null=True) 
     doEquipamentoEspaco =   models.CharField(max_length=255,blank=True, null=True)
     areaOuEdificacaoEmQueEstaInstalado =   models.CharField(max_length=255,blank=True, null=True)
     possuiFacilidade =   models.CharField(max_length=255,blank=True, null=True)
     estadoGeralConservacao =   models.CharField(max_length=255,blank=True, null=True)
     sinalizacaoIndicativaPreferencial =   models.CharField(max_length=255,blank=True, null=True)
     pessoalCapacitado =   models.JSONField(blank=True, null=True)
     rotaExternaAcessivel =   models.JSONField(blank=True, null=True)
     simboloInternacionalDeAcesso =   models.JSONField(blank=True, null=True)
     localDeEmbarqueEDesembarque =   models.JSONField(blank=True, null=True)
     vagaEmEstacionamento =   models.JSONField(blank=True, null=True)
     areaDeCirculacao =   models.JSONField(blank=True, null=True)
     escada =   models.JSONField(blank=True, null=True)
     rampa =   models.JSONField(blank=True, null=True)
     piso =   models.JSONField(blank=True, null=True)
     elevador =   models.JSONField(blank=True, null=True)
     equipamentoMotorizado =   models.JSONField(blank=True, null=True)
     sinalizacaoVisual =   models.JSONField(blank=True, null=True)
     sinalizacaoTatil =   models.JSONField(blank=True, null=True)
     alarmeDeEmergencia =   models.JSONField(blank=True, null=True)
     comunicacao =   models.JSONField(blank=True, null=True)
     balcaoDeAtendimento =   models.JSONField(blank=True, null=True)
     mobiliario =   models.JSONField(blank=True, null=True)
     sanitario =   models.JSONField(blank=True, null=True)
     telefone =   models.JSONField(blank=True, null=True)
     tabelEquipamentoEEspaco =  models.JSONField(blank=True, null=True)
     tabelaAreaOuEdificacao = models.JSONField(blank=True, null=True)
     tabelaHorarios = models.JSONField(blank=True, null=True)




    