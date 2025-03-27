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

class MeiosDeHospedagem(models.Model):
   
    # Dados do formulário e pesquisador
    tipo_formulario = models.CharField("Tipo de Formulário", max_length=255)
    nome_pesquisador = models.CharField("Nome do Pesquisador", max_length=255)
    telefone_pesquisador = models.CharField("Telefone do Pesquisador", max_length=50)
    email_pesquisador = models.EmailField("Email do Pesquisador", max_length=254)
    
    # Dados do coordenador
    nome_coordenador = models.CharField("Nome do Coordenador", max_length=255)
    telefone_coordenador = models.CharField("Telefone do Coordenador", max_length=50)
    email_coordenador = models.EmailField("Email do Coordenador", max_length=254)
    
    # Sinalizações e funcionamento
    sinalizacaoDeAcesso = models.BooleanField("Sinalização de Acesso", default=False)
    sinalizacaoTuristica = models.BooleanField("Sinalização Turística", default=False)
    funcionamento24h = models.BooleanField("Funcionamento 24h", default=False)
    funcionamentoEmFeriados = models.BooleanField("Funcionamento em Feriados", default=False)
    geradorDeEmergencia = models.BooleanField("Gerador de Emergência", default=False)
    
    # Infraestrutura e localização do equipamento/edificação
    doEquipamentoEspaco = models.TextField("Do Equipamento/Espaço", blank=True, null=True)
    daAreaOuEdificacaoEmQueEstaLocalizado = models.TextField("Da Área/Edificação em que Está Localizado", blank=True, null=True)
    possuiFacilidade = models.BooleanField("Possui Facilidade", default=False)
    sinalizacaoIndicativa = models.BooleanField("Sinalização Indicativa", default=False)
    tipoDeOrganizacao = models.CharField("Tipo de Organização", max_length=255, blank=True, null=True)
    proximidades = models.TextField("Proximidades", blank=True, null=True)
    
    # Dados relacionados ao turismo e pagamentos
    segmentosOuTurismoEspecializado = models.TextField("Segmentos ou Turismo Especializado", blank=True, null=True)
    formasDePagamento = models.TextField("Formas de Pagamento", blank=True, null=True)
    reservas = models.BooleanField("Reservas", default=False)
    atendimentoEmLinguaEstrangeira = models.BooleanField("Atendimento em Língua Estrangeira", default=False)
    informativosImpressos = models.BooleanField("Informativos Impressos", default=False)
    restricoes = models.TextField("Restrições", blank=True, null=True)
    mesesAltaTemporada = models.TextField("Meses de Alta Temporada", blank=True, null=True)
    origemDosVisitantes = models.TextField("Origem dos Visitantes", blank=True, null=True)
    
    # Produtos e serviços
    produtosHigienePessoal = models.TextField("Produtos de Higiene Pessoal", blank=True, null=True)
    equipamentosEServicos = models.TextField("Equipamentos e Serviços", blank=True, null=True)
    estacionamento = models.BooleanField("Estacionamento", default=False)
    restaurante = models.BooleanField("Restaurante", default=False)
    lanchonete = models.BooleanField("Lanchonete", default=False)
    instalacaoEEspacos = models.TextField("Instalação e Espaços", blank=True, null=True)
    outrosEspacosEAtividades = models.TextField("Outros Espaços e Atividades", blank=True, null=True)
    servicos = models.TextField("Serviços", blank=True, null=True)
    equipamentos = models.TextField("Equipamentos", blank=True, null=True)
    facilidadesEServicos = models.TextField("Facilidades e Serviços", blank=True, null=True)
    facilidadesParaExecutivos = models.TextField("Facilidades para Executivos", blank=True, null=True)
    pessoalCapacitadoParaReceberPCD = models.BooleanField("Pessoal Capacitado para Receber PCD", default=False)
    
    # Acessibilidade
    rotaExternaAcessivel = models.BooleanField("Rota Externa Acessível", default=False)
    simboloInternacionalDeAcesso = models.BooleanField("Símbolo Internacional de Acesso", default=False)
    localDeEmbarqueEDesembarque = models.BooleanField("Local de Embarque e Desembarque", default=False)
    vagaEmEstacionamento = models.BooleanField("Vaga em Estacionamento", default=False)
    areaDeCirculacaoAcessoInterno = models.TextField("Área de Circulação/Acesso Interno", blank=True, null=True)
    escada = models.BooleanField("Escada", default=False)
    rampa = models.BooleanField("Rampa", default=False)
    piso = models.BooleanField("Piso", default=False)
    elevador = models.BooleanField("Elevador", default=False)
    equipamentoMotorizadoParaDeslocamentoInterno = models.BooleanField("Equipamento Motorizado para Deslocamento Interno", default=False)
    sinalizacaoVisual = models.BooleanField("Sinalização Visual", default=False)
    sinalizacaoTatil = models.BooleanField("Sinalização Tátil", default=False)
    alarmeDeEmergencia = models.BooleanField("Alarme de Emergência", default=False)
    comunicacao = models.BooleanField("Comunicação", default=False)
    balcaoDeAtendimento = models.BooleanField("Balcão de Atendimento", default=False)
    mobiliario = models.TextField("Mobiliário", blank=True, null=True)
    sanitario = models.TextField("Sanitário", blank=True, null=True)
    telefone = models.CharField("Telefone", max_length=50, blank=True, null=True)
    
    # Classificação e localização do meio de hospedagem
    tipo = models.CharField("Tipo", max_length=255, blank=True, null=True)
    subtipo = models.CharField("Subtipo", max_length=255, blank=True, null=True)
    natureza = models.CharField("Natureza", max_length=255, blank=True, null=True)
    localizacao = models.TextField("Localização", blank=True, null=True)
    tipoDeDiaria = models.CharField("Tipo de Diária", max_length=255, blank=True, null=True)
    periodo = models.CharField("Período", max_length=255, blank=True, null=True)
    tabelasHorario = models.TextField("Tabelas de Horário", blank=True, null=True)
    energiaEletrica = models.TextField("Energia Elétrica", blank=True, null=True)
    estadoGeralDeConservacao = models.CharField("Estado Geral de Conservação", max_length=255, blank=True, null=True)
    
    # Dados de turismo e localização geográfica
    estadosTuristas = models.TextField("Estados Turistas", blank=True, null=True)
    paisesTuristas = models.TextField("Países Turistas", blank=True, null=True)
    uf = models.CharField("UF", max_length=2, blank=True, null=True)
    regiao_turistica = models.CharField("Região Turística", max_length=255, blank=True, null=True)
    municipio = models.CharField("Município", max_length=255, blank=True, null=True)
    
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
    latitude = models.DecimalField("Latitude", max_digits=9, decimal_places=6, blank=True, null=True)
    longitute = models.DecimalField("Longitude", max_digits=9, decimal_places=6, blank=True, null=True)
    
    # Endereço e contato
    avenidaRuaEtc = models.CharField("Avenida/Rua/etc.", max_length=255, blank=True, null=True)
    bairroLocalidade = models.CharField("Bairro/Localidade", max_length=255, blank=True, null=True)
    distrito = models.CharField("Distrito", max_length=255, blank=True, null=True)
    CEP = models.CharField("CEP", max_length=20, blank=True, null=True)
    whatsapp = models.CharField("WhatsApp", max_length=50, blank=True, null=True)
    instagram = models.CharField("Instagram", max_length=100, blank=True, null=True)
    email = models.EmailField("Email", max_length=254, blank=True, null=True)
    site = models.URLField("Site", blank=True, null=True)
    pontosDeReferencia = models.TextField("Pontos de Referência", blank=True, null=True)
    
    # Dados de tabelas e informações adicionais
    tabelaMTUR = models.TextField("Tabela MTUR", blank=True, null=True)
    outrasRegrasEInformacoes = models.TextField("Outras Regras e Informações", blank=True, null=True)
    nAnoOcupacao = models.IntegerField("Ano de Ocupação", default=0)
    nOcupacaoAltaTemporada = models.IntegerField("Ocupação em Alta Temporada", default=0)
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
    tabelaInstalacoes = models.TextField("Tabela Instalações", blank=True, null=True)
    tabelaEquipamentoEEspaco = models.TextField("Tabela Equipamento e Espaço", blank=True, null=True)
    tabelaEquipamentoEEspaco2 = models.TextField("Tabela Equipamento e Espaço 2", blank=True, null=True)
    
    # Observações e referências
    outros = models.TextField("Outros", blank=True, null=True)
    observacoes = models.TextField("Observações", blank=True, null=True)
    referencias = models.TextField("Referências", blank=True, null=True)