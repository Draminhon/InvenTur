class ServicosParaEventosModel {
  int? id;
  int? usuario_criador;
  String? tipoFormulario;
  String? uf;
  String? regiaoTuristica;
  String? municipio;
  String? tipo;
  String? observacoes;
  String? referencias;
  String? nomePesquisador;
  String? geradorCapacidadeEmKVA;
  String? telefonePesquisador;
  String? emailPesquisador;
  String? nomeCoordenador;
  String? telefoneCoordenador;
  String? emailCoordenador;
  List<String>? atividadesBasicas;
  List<String>? equipamentosEServicos;
  // Sinalizações e funcionamento
  String? sinalizacaoDeAcesso;
  String? sinalizacaoTuristica;
  String? funcionamento24h;
  String? funcionamentoEmFeriados;
  String? geradorDeEmergencia;
  // Infraestrutura e localização do equipamento/edificação
  String? doEquipamentoEspaco;
  String? daAreaOuEdificacaoEmQueEstaLocalizado;
  String? possuiFacilidade;
  String? sinalizacaoIndicativa;
  List<String>? tipoDeOrganizacao;
  List<String>? proximidades;

  // Dados relacionados ao turismo e pagamentos
  List<String>? formasDePagamento;
  List<String>? reservas;
  List<String>? atendimentoEmLinguaEstrangeira;
  List<String>? informativosImpressos;
  List<String>? restricoes;

  // Produtos e serviços
  List<String>? lanchonete;
  List<String>? servicos;
  List<String>? equipamentos;
  List<String>? facilidadesEServicos;
  List<String>? facilidadesParaExecutivos;
  List<String>? pessoalCapacitadoParaReceberPCD;

  // Acessibilidade
  List<String>? rotaExternaAcessivel;
  List<String>? simboloInternacionalDeAcesso;
  List<String>? localDeEmbarqueEDesembarque;
  List<String>? vagaEmEstacionamento;
  List<String>? areaDeCirculacaoAcessoInterno;
  List<String>? escada;
  List<String>? rampa;
  List<String>? piso;
  List<String>? elevador;
  List<String>? equipamentoMotorizadoParaDeslocamentoInterno;
  List<String>? sinalizacaoVisual;
  List<String>? sinalizacaoTatil;
  List<String>? alarmeDeEmergencia;
  List<String>? comunicacao;
  List<String>? balcaoDeAtendimento;
  List<String>? mobiliario;
  List<String>? sanitario;
  List<String>? telefone;

  // Classificação e localização do meio de hospedagem
  String? subtipo;
  String? natureza;
  String? localizacao;
  String? tipoDeDiaria;
  List<String>? periodo;
  Map<String, dynamic>? tabelasHorario;
  String? estadoGeralDeConservacao;

  // Dados de turismo e localização geográfica

  // Dados empresariais
  String? razaoSocial;
  String? nomeFantasia;
  String? codigoCNAE;
  String? atividadeEconomica;
  String? inscricaoMunicipal;
  String? nomeDaRede;
  String? CNPJ;
  String? inicioDaAtividade;

  // Dados de quantitativos e capacidade
  String? qtdeFuncionariosPermanentes;
  String? qtdeFuncionariosTemporarios;
  String? qtdeFuncionarisComDeficiencia;
  String? latitude;
  String? longitude;

  // Endereço e contato
  String? avenidaRuaEtc;
  String? bairroLocalidade;
  String? distrito;
  String? CEP;
  String? whatsapp;
  String? instagram;
  String? email;
  String? site;
  String? pontosDeReferencia;
  // Dados de tabelas e informações adicionais
  Map<String, dynamic>? tabelaMTUR;
  String? outrasRegrasEInformacoes;
  String? nCapacidadeDeVeiculos;
  String? nAutomoveis;
  String? nOnibus;
  Map<String, dynamic>? tabelaEquipamentoEEspaco;
  Map<String, dynamic>? tabelaEquipamentoEEspaco2;
  String? outros;
  String? outrasAcessibilidade;
  ServicosParaEventosModel(
      {this.id,
      this.usuario_criador,
      this.tipoFormulario,
      this.geradorCapacidadeEmKVA,
      this.uf,
      this.regiaoTuristica,
      this.municipio,
      this.tipo,
      this.observacoes,
      this.referencias,
      this.nomePesquisador,
      this.telefonePesquisador,
      this.emailPesquisador,
      this.nomeCoordenador,
      this.telefoneCoordenador,
      this.emailCoordenador,
      this.sinalizacaoDeAcesso,
      this.sinalizacaoTuristica,
      this.equipamentosEServicos,
      this.funcionamento24h,
      this.funcionamentoEmFeriados,
      this.atividadesBasicas,
      this.geradorDeEmergencia,
      this.doEquipamentoEspaco,
      this.daAreaOuEdificacaoEmQueEstaLocalizado,
      this.possuiFacilidade,
      this.sinalizacaoIndicativa,
      this.tipoDeOrganizacao,
      this.proximidades,
      this.formasDePagamento,
      this.reservas,
      this.atendimentoEmLinguaEstrangeira,
      this.informativosImpressos,
      this.restricoes,
      this.lanchonete,
      this.servicos,
      this.equipamentos,
      this.facilidadesEServicos,
      this.facilidadesParaExecutivos,
      this.pessoalCapacitadoParaReceberPCD,
      this.rotaExternaAcessivel,
      this.simboloInternacionalDeAcesso,
      this.localDeEmbarqueEDesembarque,
      this.vagaEmEstacionamento,
      this.areaDeCirculacaoAcessoInterno,
      this.escada,
      this.rampa,
      this.piso,
      this.elevador,
      this.equipamentoMotorizadoParaDeslocamentoInterno,
      this.sinalizacaoVisual,
      this.sinalizacaoTatil,
      this.alarmeDeEmergencia,
      this.comunicacao,
      this.balcaoDeAtendimento,
      this.mobiliario,
      this.sanitario,
      this.telefone,
      this.subtipo,
      this.natureza,
      this.localizacao,
      this.tipoDeDiaria,
      this.periodo,
      this.tabelasHorario,
      this.estadoGeralDeConservacao,
      this.razaoSocial,
      this.nomeFantasia,
      this.codigoCNAE,
      this.atividadeEconomica,
      this.inscricaoMunicipal,
      this.nomeDaRede,
      this.CNPJ,
      this.inicioDaAtividade,
      this.qtdeFuncionariosPermanentes,
      this.qtdeFuncionariosTemporarios,
      this.qtdeFuncionarisComDeficiencia,
      this.latitude,
      this.longitude,
      this.avenidaRuaEtc,
      this.bairroLocalidade,
      this.distrito,
      this.CEP,
      this.whatsapp,
      this.instagram,
      this.email,
      this.site,
      this.pontosDeReferencia,
      this.tabelaMTUR,
      this.outrasRegrasEInformacoes,
      this.nCapacidadeDeVeiculos,
      this.nAutomoveis,
      this.nOnibus,
      this.tabelaEquipamentoEEspaco,
      this.tabelaEquipamentoEEspaco2,
      this.outros,
      this.outrasAcessibilidade});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_criador': usuario_criador,
      'tipo_formulario': tipoFormulario,
      'atividadesBasicas': atividadesBasicas,
        'geradorCapacidadeEmKVA': geradorCapacidadeEmKVA,
        "equipamentosEServicos": equipamentosEServicos,
      'uf': uf,
      'regiao_turistica': regiaoTuristica,
      'municipio': municipio,
      'tipo': tipo,
      'observacoes': observacoes,
      'referencias': referencias,
      'nome_pesquisador': nomePesquisador,
      'telefone_pesquisador': telefonePesquisador,
      'email_pesquisador': emailPesquisador,
      'nome_coordenador': nomeCoordenador,
      'telefone_coordenador': telefoneCoordenador,
      'email_coordenador': emailCoordenador,
      'sinalizacaoDeAcesso': sinalizacaoDeAcesso,
      'sinalizacaoTuristica': sinalizacaoTuristica,
      'funcionamento24h': funcionamento24h,
      'funcionamentoEmFeriados': funcionamentoEmFeriados,
      'geradorDeEmergencia': geradorDeEmergencia,
      'doEquipamentoEspaco': doEquipamentoEspaco,
      'daAreaOuEdificacaoEmQueEstaLocalizado':
          daAreaOuEdificacaoEmQueEstaLocalizado,
      'possuiFacilidade': possuiFacilidade,
      'sinalizacaoIndicativa': sinalizacaoIndicativa,
      'tipoDeOrganizacao': tipoDeOrganizacao,
      'proximidades': proximidades,
      'formasDePagamento': formasDePagamento,
      'reservas': reservas,
      'atendimentoEmLinguaEstrangeira': atendimentoEmLinguaEstrangeira,
      'informativosImpressos': informativosImpressos,
      'restricoes': restricoes,
      'lanchonete': lanchonete,
      'servicos': servicos,
      'equipamentos': equipamentos,
      'facilidadesEServicos': facilidadesEServicos,
      'facilidadesParaExecutivos': facilidadesParaExecutivos,
      'pessoalCapacitadoParaReceberPCD': pessoalCapacitadoParaReceberPCD,
      'rotaExternaAcessivel': rotaExternaAcessivel,
      'simboloInternacionalDeAcesso': simboloInternacionalDeAcesso,
      'localDeEmbarqueEDesembarque': localDeEmbarqueEDesembarque,
      'vagaEmEstacionamento': vagaEmEstacionamento,
      'areaDeCirculacaoAcessoInterno': areaDeCirculacaoAcessoInterno,
      'escada': escada,
      'rampa': rampa,
      'piso': piso,
      'elevador': elevador,
      'equipamentoMotorizadoParaDeslocamentoInterno':
          equipamentoMotorizadoParaDeslocamentoInterno,
      'sinalizacao_visual': sinalizacaoVisual,
      'sinalizacaoTatil': sinalizacaoTatil,
      'alarmeDeEmergencia': alarmeDeEmergencia,
      'comunicacao': comunicacao,
      'balcaoDeAtendimento': balcaoDeAtendimento,
      'mobiliario': mobiliario,
      'sanitario': sanitario,
      'telefone': telefone,
      'subtipo': subtipo,
      'natureza': natureza,
      'localizacao': localizacao,
      'tipoDeDiaria': tipoDeDiaria,
      'periodo': periodo,
      'tabelasHorario': tabelasHorario,
      'estadoGeralDeConservacao': estadoGeralDeConservacao,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'codigoCNAE': codigoCNAE,
      'atividadeEconomica': atividadeEconomica,
      'inscricaoMunicipal': inscricaoMunicipal,
      'nomeDaRede': nomeDaRede,
      'CNPJ': CNPJ,
      'inicioDaAtividade': inicioDaAtividade,
      'qtdeFuncionariosPermanentes': qtdeFuncionariosPermanentes,
      'qtdeFuncionariosTemporarios': qtdeFuncionariosTemporarios,
      'qtdeFuncionarisComDeficiencia': qtdeFuncionarisComDeficiencia,
      'latitude': latitude,
      'longitude': longitude,
      'avenidaRuaEtc': avenidaRuaEtc,
      'bairroLocalidade': bairroLocalidade,
      'distrito': distrito,
      'CEP': CEP,
      'whatsapp': whatsapp,
      'instagram': instagram,
      'email': email,
      'site': site,
      'pontosDeReferencia': pontosDeReferencia,
      'tabelaMTUR': tabelaMTUR,
      'outrasRegrasEInformacoes': outrasRegrasEInformacoes,
      'nCapacidadeDeVeiculos': nCapacidadeDeVeiculos,
      'nAutomoveis': nAutomoveis,
      'nOnibus': nOnibus,
      'tabelaEquipamentoEEspaco': tabelaEquipamentoEEspaco,
      'tabelaEquipamentoEEspaco2': tabelaEquipamentoEEspaco2,
      'outros': outros,
      'outrasAcessibilidade': outrasAcessibilidade
    };
  }

  ServicosParaEventosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario_criador = json['usuario_criador'];
    atividadesBasicas = List<String>.from(json['atividadesBasicas'] ??[]);
    equipamentosEServicos = List<String>.from(json['equipamentosEServicos'] ?? []); 
        geradorCapacidadeEmKVA = json['geradorCapacidadeEmKVA'];
    tipoFormulario = json['tipo_formulario'];
    uf = json['uf'];
    regiaoTuristica = json['regiao_turistica'];
    municipio = json['municipio'];
    tipo = json['tipo'];
    observacoes = json['observacoes'];
    referencias = json['referencias'];
    nomePesquisador = json['nome_pesquisador'];
    telefonePesquisador = json['telefone_pesquisador'];
    emailPesquisador = json['email_pesquisador'];
    nomeCoordenador = json['nome_coordenador'];
    telefoneCoordenador = json['telefone_coordenador'];
    emailCoordenador = json['email_coordenador'];
    sinalizacaoDeAcesso = json['sinalizacaoDeAcesso'];
    sinalizacaoTuristica = json['sinalizacaoTuristica'];
    funcionamento24h = json['funcionamento24h'];
    funcionamentoEmFeriados = json['funcionamentoEmFeriados'];
    geradorDeEmergencia = json['geradorDeEmergencia'];
    doEquipamentoEspaco = json['doEquipamentoEspaco'];
    daAreaOuEdificacaoEmQueEstaLocalizado =
        json['daAreaOuEdificacaoEmQueEstaLocalizado'];
    possuiFacilidade = json['possuiFacilidade'];
    sinalizacaoIndicativa = json['sinalizacaoIndicativa'];
    tipoDeOrganizacao = json['tipoDeOrganizacao'] != null
        ? List<String>.from(json['tipoDeOrganizacao'] ?? [])
        : null;
    proximidades = json['proximidades'] != null
        ? List<String>.from(json['proximidades'] ?? [])
        : null;

    formasDePagamento = List<String>.from(json['formasDePagamento'] ?? []);
    reservas = List<String>.from(json['reservas'] ?? []);
    atendimentoEmLinguaEstrangeira =
        List<String>.from(json['atendimentoEmLinguaEstrangeira'] ?? []);
    informativosImpressos =
        List<String>.from(json['informativosImpressos'] ?? []);
    restricoes = List<String>.from(json['restricoes'] ?? []);

    lanchonete = List<String>.from(json['lanchonete'] ?? []);
    servicos = List<String>.from(json['servicos'] ?? []);
    equipamentos = List<String>.from(json['equipamentos'] ?? []);
    facilidadesEServicos =
        List<String>.from(json['facilidadesEServicos'] ?? []);
    facilidadesParaExecutivos =
        List<String>.from(json['facilidadesParaExecutivos'] ?? []);
    pessoalCapacitadoParaReceberPCD =
        List<String>.from(json['pessoalCapacitadoParaReceberPCD'] ?? []);
    rotaExternaAcessivel =
        List<String>.from(json['rotaExternaAcessivel'] ?? []);
    simboloInternacionalDeAcesso =
        List<String>.from(json['simboloInternacionalDeAcesso'] ?? []);
    localDeEmbarqueEDesembarque =
        List<String>.from(json['localDeEmbarqueEDesembarque'] ?? []);
    vagaEmEstacionamento =
        List<String>.from(json['vagaEmEstacionamento'] ?? []);
    areaDeCirculacaoAcessoInterno =
        List<String>.from(json['areaDeCirculacaoAcessoInterno'] ?? []);
    escada = List<String>.from(json['escada'] ?? []);
    rampa = List<String>.from(json['rampa'] ?? []);
    piso = List<String>.from(json['piso'] ?? []);
    elevador = List<String>.from(json['elevador'] ?? []);
    equipamentoMotorizadoParaDeslocamentoInterno = List<String>.from(
        json['equipamentoMotorizadoParaDeslocamentoInterno'] ?? []);
    sinalizacaoVisual = List<String>.from(json['sinalizacaoVisual'] ?? []);
    sinalizacaoTatil = List<String>.from(json['sinalizacaoTatil'] ?? []);
    alarmeDeEmergencia = List<String>.from(json['alarmeDeEmergencia'] ?? []);
    comunicacao = List<String>.from(json['comunicacao'] ?? []);
    balcaoDeAtendimento = List<String>.from(json['balcaoDeAtendimento'] ?? []);
    mobiliario = List<String>.from(json['mobiliario'] ?? []);
    sanitario = List<String>.from(json['sanitario'] ?? []);
    telefone = List<String>.from(json['telefone'] ?? []);
    subtipo = json['subtipo'];
    natureza = json['natureza'];
    localizacao = json['localizacao'];
    tipoDeDiaria = json['tipoDeDiaria'];
    periodo = List<String>.from(json['periodo'] ?? []);
    tabelasHorario = Map<String, dynamic>.from(json['tabelasHorario'] ?? {});
    estadoGeralDeConservacao = json['estadoGeralDeConservacao'];
    razaoSocial = json['razaoSocial'];
    nomeFantasia = json['nomeFantasia'];
    codigoCNAE = json['codigoCNAE'];
    atividadeEconomica = json['atividadeEconomica'];
    inscricaoMunicipal = json['inscricaoMunicipal'];
    nomeDaRede = json['nomeDaRede'];
    CNPJ = json['CNPJ'];
    inicioDaAtividade = json['inicioDaAtividade'];
    qtdeFuncionariosPermanentes = json['qtdeFuncionariosPermanentes'];
    qtdeFuncionariosTemporarios = json['qtdeFuncionariosTemporarios'];
    qtdeFuncionarisComDeficiencia = json['qtdeFuncionarisComDeficiencia'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    avenidaRuaEtc = json['avenidaRuaEtc'];
    bairroLocalidade = json['bairroLocalidade'];
    distrito = json['distrito'];
    CEP = json['CEP'];
    whatsapp = json['whatsapp'];
    instagram = json['instagram'];
    email = json['email'];
    site = json['site'];
    pontosDeReferencia = json['pontosDeReferencia'];
    tabelaMTUR = Map<String, dynamic>.from(json['tabelaMTUR'] ?? {});
    outrasRegrasEInformacoes = json['outrasRegrasEInformacoes'];
    nCapacidadeDeVeiculos = json['nCapacidadeDeVeiculos'];
    nAutomoveis = json['nAutomoveis'];
    nOnibus = json['nOnibus'];
    tabelaEquipamentoEEspaco =
        Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco'] ?? {});
    tabelaEquipamentoEEspaco2 =
        Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco2'] ?? {});
    outros = json['outros'];
    outrasAcessibilidade = json['outrasAcessibilidade'];
  }
}
