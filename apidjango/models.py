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

    pesquisas = models.ManyToManyField("Pesquisa", related_name="pesquisas", blank=True)
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
    subtipo = models.CharField("Subtipo", max_length=255, blank=True, null=True)
    natureza = models.CharField("Natureza", max_length=255, blank=True, null=True)
    localizacao = models.TextField("Localização", blank=True, null=True)
    tipoDeDiaria = models.CharField("Tipo de Diária", max_length=255, blank=True, null=True)
    periodo = models.CharField("Período", max_length=255, blank=True, null=True)
    tabelasHorario = models.JSONField("Tabelas de Horário",blank=True,null=True)
    energiaEletrica = models.TextField("Energia Elétrica", blank=True, null=True)
    estadoGeralDeConservacao = models.CharField("Estado Geral de Conservação", max_length=255, blank=True, null=True)
    
    # Dados de turismo e localização geográfica
    estadosTuristas = models.JSONField("Estados Turistas", blank=True)
    paisesTuristas = models.JSONField("Países Turistas", blank=True)
    
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


