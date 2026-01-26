class EspacosDeDiversaoECulturaModel {
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
  String? telefonePesquisador;
  String? emailPesquisador;
  String? nomeCoordenador;
  String? telefoneCoordenador;
  String? emailCoordenador;

  String? permissaoDeAcesso;

  String? ambientacaoTematica;
  String? entidadeManetedora;
  String? entidadeManetedoraEmail;
  String? entidadeManetedoraSite;
  String? entradaGratuita;
  String? entradaPaga;
  // Sinalizações e funcionamento
  String? sinalizacaoDeAcesso;
  String? sinalizacaoTuristica;
  String? funcionamento24h;
  String? funcionamentoEmFeriados;

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
  List<String>? mesesAltaTemporada;
  List<String>? origemDosVisitantes;

  // Produtos e serviços
  List<String>? produtosHigienePessoal;
  List<String>? equipamentosEServicos;
  List<String>? estacionamento;
  List<String>? outrasIntalacoes;
  List<String>? lanchonete;
  List<String>? instalacaoEEspacos;
  List<String>? outrosEspacosEAtividades;
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
  List<String>? subtipo;
  String? natureza;
  String? localizacao;
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
  String? nAnoOcupacao;
  String? nUhAdaptadasParaPCD;
  String? nCapacidadeDeVeiculos;
  String? nAutomoveis;
  String? nOnibus;
  String? capacidadeEmKVA;
  String? geradorCapacidadeEmKVA;
  String? nCapacidadeInstaladaPorDia;
  String? nPessoasAtendidasSentadas;
  String? nCapacidadeSimultanea;
  String? nPessoasAtendidasSentadasSimultanea;
  String? lanchoneteCapacidadeInstaladaPorDia;
  String? lanchoneteCapacidadePessoasAtendidasSentadas;
  String? lanchoneteCapacidadeSimultanea;
  String? lanchoneteCapacidadeSentadasSimultanea;
  Map<String, dynamic>? tabelaInstalacoes;
  Map<String, dynamic>? tabelaEquipamentoEEspaco;
  Map<String, dynamic>? tabelaEquipamentoEEspaco2;
  String? outros;
  String? outrasAcessibilidade;
  EspacosDeDiversaoECulturaModel({
    this.id,
    this.usuario_criador,
    this.tipoFormulario,
    this.uf,
    this.regiaoTuristica,
    this.municipio,
    this.tipo,
    this.ambientacaoTematica,
    this.observacoes,
    this.permissaoDeAcesso,
    this.referencias,
    this.nomePesquisador,
    this.telefonePesquisador,
    this.entidadeManetedora,
    this.entidadeManetedoraEmail,
    this.entidadeManetedoraSite,
    this.entradaGratuita,
    this.entradaPaga,
    this.emailPesquisador,
    this.nomeCoordenador,
    this.telefoneCoordenador,
    this.emailCoordenador,
    this.sinalizacaoDeAcesso,
    this.sinalizacaoTuristica,
    this.funcionamento24h,
    this.funcionamentoEmFeriados,
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
    this.mesesAltaTemporada,
    this.origemDosVisitantes,
    this.produtosHigienePessoal,
    this.equipamentosEServicos,
    this.estacionamento,
    this.outrasIntalacoes,
    this.lanchonete,
    this.instalacaoEEspacos,
    this.outrosEspacosEAtividades,
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
    this.nAnoOcupacao,
    this.nUhAdaptadasParaPCD,
    this.nCapacidadeDeVeiculos,
    this.nAutomoveis,
    this.nOnibus,
    this.capacidadeEmKVA,
    this.geradorCapacidadeEmKVA,
    this.nCapacidadeInstaladaPorDia,
    this.nPessoasAtendidasSentadas,
    this.nCapacidadeSimultanea,
    this.nPessoasAtendidasSentadasSimultanea,
    this.lanchoneteCapacidadeInstaladaPorDia,
    this.lanchoneteCapacidadePessoasAtendidasSentadas,
    this.lanchoneteCapacidadeSimultanea,
    this.lanchoneteCapacidadeSentadasSimultanea,
    this.tabelaInstalacoes,
    this.tabelaEquipamentoEEspaco,
    this.tabelaEquipamentoEEspaco2,
    this.outros,
    this.outrasAcessibilidade
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_criador':usuario_criador,
      'tipo_formulario': tipoFormulario,
      'uf': uf,
      'permissaoDeAcesso': permissaoDeAcesso,
      'regiao_turistica': regiaoTuristica,
      'municipio': municipio,
      'tipo': tipo,
      'observacoes': observacoes,
      'referencias': referencias,
      'entradaGratuita': entradaGratuita,
      'entradaPaga': entradaPaga,
      'entidadeManetedora' : entidadeManetedora,
    'entidadeManetedoraEmail' : entidadeManetedoraEmail,
    'entidadeManetedoraSite' : entidadeManetedoraSite,
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
      'doEquipamentoEspaco': doEquipamentoEspaco,
    'ambientacaoTematica' : ambientacaoTematica,
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
      'mesesAltaTemporada': mesesAltaTemporada,
      'origemDosVisitantes': origemDosVisitantes,
      'produtosHigienePessoal': produtosHigienePessoal,
      'equipamentosEServicos': equipamentosEServicos,
      'estacionamento': estacionamento,
      'outrasIntalacoes': outrasIntalacoes,
      'lanchonete': lanchonete,
      'instalacaoEEspacos': instalacaoEEspacos,
      'outrosEspacosEAtividades': outrosEspacosEAtividades,
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
      'nAnoOcupacao': nAnoOcupacao,
      'nUhAdaptadasParaPCD': nUhAdaptadasParaPCD,
      'nCapacidadeDeVeiculos': nCapacidadeDeVeiculos,
      'nAutomoveis': nAutomoveis,
      'nOnibus': nOnibus,
      'capacidadeEmKVA': capacidadeEmKVA,
      'geradorCapacidadeEmKVA': geradorCapacidadeEmKVA,
      'nCapacidadeInstaladaPorDia': nCapacidadeInstaladaPorDia,
      'nPessoasAtendidasSentadas': nPessoasAtendidasSentadas,
      'nCapacidadeSimultanea': nCapacidadeSimultanea,
      'nPessoasAtendidasSentadasSimultanea':
          nPessoasAtendidasSentadasSimultanea,
      'lanchoneteCapacidadeInstaladaPorDia':
          lanchoneteCapacidadeInstaladaPorDia,
      'lanchoneteCapacidadePessoasAtendidasSentadas':
          lanchoneteCapacidadePessoasAtendidasSentadas,
      'lanchoneteCapacidadeSimultanea': lanchoneteCapacidadeSimultanea,
      'lanchoneteCapacidadeSentadasSimultanea':
          lanchoneteCapacidadeSentadasSimultanea,
      'tabelaInstalacoes': tabelaInstalacoes,
      'tabelaEquipamentoEEspaco': tabelaEquipamentoEEspaco,
      'tabelaEquipamentoEEspaco2': tabelaEquipamentoEEspaco2,
      'outros': outros,
      'outrasAcessibilidade': outrasAcessibilidade,
    };
  }

  EspacosDeDiversaoECulturaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario_criador =json['usuario_criador'];
    tipoFormulario = json['tipo_formulario'];
    uf = json['uf'];

     entidadeManetedora= json['entidadeManetedora'];
     entidadeManetedoraEmail = json['entidadeManetedoraEmail'];
     entidadeManetedoraSite = json['entidadeManetedoraSite'];
    permissaoDeAcesso = json['permissaoDeAcesso'];
    entradaGratuita = json['entradaGratuita'];
    entradaPaga = json['entradaPaga'];

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
    doEquipamentoEspaco = json['doEquipamentoEspaco'];
    daAreaOuEdificacaoEmQueEstaLocalizado =
        json['daAreaOuEdificacaoEmQueEstaLocalizado'];
    possuiFacilidade = json['possuiFacilidade'];
    ambientacaoTematica = json['ambientacaoTematica'];
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
    mesesAltaTemporada = List<String>.from(json['mesesAltaTemporada'] ?? []);
    origemDosVisitantes = List<String>.from(json['origemDosVisitantes'] ?? []);
    produtosHigienePessoal =
        List<String>.from(json['produtosHigienePessoal'] ?? []);
    equipamentosEServicos =
        List<String>.from(json['equipamentosEServicos'] ?? []);
    estacionamento = List<String>.from(json['estacionamento'] ?? []);
    outrasIntalacoes = List<String>.from(json['outrasIntalacoes'] ?? []);
    lanchonete = List<String>.from(json['lanchonete'] ?? []);
    instalacaoEEspacos = List<String>.from(json['instalacaoEEspacos'] ?? []);
    outrosEspacosEAtividades =
        List<String>.from(json['outrosEspacosEAtividades'] ?? []);
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
    subtipo = List<String>.from(json['subtipo'] ?? []);
    natureza = json['natureza'];
    localizacao = json['localizacao'];
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
    nAnoOcupacao = json['nAnoOcupacao'];
    nUhAdaptadasParaPCD = json['nUhAdaptadasParaPCD'];
    nCapacidadeDeVeiculos = json['nCapacidadeDeVeiculos'];
    nAutomoveis = json['nAutomoveis'];
    nOnibus = json['nOnibus'];
    capacidadeEmKVA = json['capacidadeEmKVA'];
    geradorCapacidadeEmKVA = json['geradorCapacidadeEmKVA'];
    nCapacidadeInstaladaPorDia = json['nCapacidadeInstaladaPorDia'];
    nPessoasAtendidasSentadas = json['nPessoasAtendidasSentadas'];
    nCapacidadeSimultanea = json['nCapacidadeSimultanea'];
    nPessoasAtendidasSentadasSimultanea =
        json['nPessoasAtendidasSentadasSimultanea'];
    lanchoneteCapacidadeInstaladaPorDia =
        json['lanchoneteCapacidadeInstaladaPorDia'];
    lanchoneteCapacidadePessoasAtendidasSentadas =
        json['lanchoneteCapacidadePessoasAtendidasSentadas'];
    lanchoneteCapacidadeSimultanea = json['lanchoneteCapacidadeSimultanea'];
    lanchoneteCapacidadeSentadasSimultanea =
        json['lanchoneteCapacidadeSentadasSimultanea'];
    tabelaInstalacoes =
        Map<String, dynamic>.from(json['tabelaInstalacoes'] ?? {});
    tabelaEquipamentoEEspaco =
        Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco'] ?? {});
    tabelaEquipamentoEEspaco2 =
        Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco2'] ?? {});
    outros = json['outros'];
  outrasAcessibilidade = json['outrasAcessibilidade'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['tipo_formulario'] = tipoFormulario;
  //   data['uf'] = uf;
  //   data['regiao_turistica'] = regiaoTuristica;
  //   data['municipio'] = municipio;
  //   data['tipo'] = tipo;
  //   data['observacoes'] = observacoes;
  //   data['referencias'] = referencias;
  //   data['nome_pesquisador'] = nomePesquisador;
  //   data['telefone_pesquisador'] = telefonePesquisador;
  //   data['email_pesquisador'] = emailPesquisador;
  //   data['nome_coordenador'] = nomeCoordenador;
  //   data['telefone_coordenador'] = telefoneCoordenador;
  //   data['email_coordenador'] = emailCoordenador;
  //   data['sinalizacao_de_acesso'] = sinalizacaoDeAcesso;
  //   data['sinalizacao_turistica'] = sinalizacaoTuristica;
  //   data['funcionamento_24h'] = funcionamento24h;
  //   data['funcionamento_em_feriados'] = funcionamentoEmFeriados;
  //   data['gerador_de_emergencia'] = geradorDeEmergencia;
  //   data['do_equipamento_espaco'] = doEquipamentoEspaco;
  //   data['da_area_ou_edificacao_em_que_esta_localizado'] =
  //       daAreaOuEdificacaoEmQueEstaLocalizado;
  //   data['possui_facilidade'] = possuiFacilidade;
  //   data['sinalizacao_indicativa'] = sinalizacaoIndicativa;
  //   data['tipo_de_organizacao'] = tipoDeOrganizacao;
  //   data['proximidades'] = proximidades;
  //   data['segmentos_ou_turismo_especializado'] =
  //       segmentosOuTurismoEspecializado;
  //   data['formas_de_pagamento'] = formasDePagamento;
  //   data['reservas'] = reservas;
  //   data['atendimento_em_lingua_estrangeira'] = atendimentoEmLinguaEstrangeira;
  //   data['informativos_impressos'] = informativosImpressos;
  //   data['restricoes'] = restricoes;
  //   data['meses_alta_temporada'] = mesesAltaTemporada;
  //   data['origem_dos_visitantes'] = origemDosVisitantes;
  //   data['produtos_higiene_pessoal'] = produtosHigienePessoal;
  //   data['equipamentos_e_servicos'] = equipamentosEServicos;
  //   data['estacionamento'] = estacionamento;
  //   data['outrasIntalacoes'] = outrasIntalacoes;
  //   data['lanchonete'] = lanchonete;
  //   data['instalacao_e_espacos'] = instalacaoEEspacos;
  //   data['outros_espacos_e_atividades'] = outrosEspacosEAtividades;
  //   data['servicos'] = servicos;
  //   data['equipamentos'] = equipamentos;
  //   data['facilidades_e_servicos'] = facilidadesEServicos;
  //   data['facilidades_para_executivos'] = facilidadesParaExecutivos;
  //   data['pessoal_capacitado_para_receber_pcd'] =
  //       pessoalCapacitadoParaReceberPCD;
  //   data['rota_externa_acessivel'] = rotaExternaAcessivel;
  //   data['simbolo_internacional_de_acesso'] = simboloInternacionalDeAcesso;
  //   data['local_de_embarque_e_desembarque'] = localDeEmbarqueEDesembarque;
  //   data['vaga_em_estacionamento'] = vagaEmEstacionamento;
  //   data['area_de_circulacao_acesso_interno'] = areaDeCirculacaoAcessoInterno;
  //   data['escada'] = escada;
  //   data['rampa'] = rampa;
  //   data['piso'] = piso;
  //   data['elevador'] = elevador;
  //   data['equipamento_motorizado_para_deslocamento_interno'] =
  //       equipamentoMotorizadoParaDeslocamentoInterno;
  //   data['sinalizacao_visual'] = sinalizacaoVisual;
  //   data['sinalizacao_tatil'] = sinalizacaoTatil;
  //   data['alarme_de_emergencia'] = alarmeDeEmergencia;
  //   data['comunicacao'] = comunicacao;
  //   data['balcao_de_atendimento'] = balcaoDeAtendimento;
  //   data['mobiliario'] = mobiliario;
  //   data['sanitario'] = sanitario;
  //   data['telefone'] = telefone;
  //   data['subtipo'] = subtipo;
  //   data['natureza'] = natureza;
  //   data['localizacao'] = localizacao;
  //   data['tipo_de_diaria'] = tipoDeDiaria;
  //   data['periodo'] = periodo;
  //   data['tabelas_horario'] = tabelasHorario;
  //   data['energia_eletrica'] = energiaEletrica;
  //   data['estado_geral_de_conservacao'] = estadoGeralDeConservacao;
  //   data['estados_turistas'] = estadosTuristas;
  //   data['paises_turistas'] = paisesTuristas;
  //   data['razao_social'] = razaoSocial;
  //   data['nome_fantasia'] = nomeFantasia;
  //   data['codigo_cnae'] = codigoCNAE;
  //   data['atividade_economica'] = atividadeEconomica;
  //   data['inscricao_municipal'] = inscricaoMunicipal;
  //   data['nome_da_rede'] = nomeDaRede;
  //   data['cnpj'] = CNPJ;
  //   data['inicio_da_atividade'] = inicioDaAtividade;
  //   data['qtde_funcionarios_permanentes'] = qtdeFuncionariosPermanentes;
  //   data['qtde_funcionarios_temporarios'] = qtdeFuncionariosTemporarios;
  //   data['qtde_funcionarios_com_deficiencia'] = qtdeFuncionarisComDeficiencia;
  //   data['latitude'] = latitude;
  //   data['longitude'] = longitude;
  //   data['avenida_rua_etc'] = avenidaRuaEtc;
  //   data['bairro_localidade'] = bairroLocalidade;
  //   data['distrito'] = distrito;
  //   data['cep'] = CEP;
  //   data['whatsapp'] = whatsapp;
  //   data['instagram'] = instagram;
  //   data['email'] = email;
  //   data['site'] = site;
  //   data['pontos_de_referencia'] = pontosDeReferencia;
  //   data['tabela_mtur'] = tabelaMTUR;
  //   data['outras_regras_e_informacoes'] = outrasRegrasEInformacoes;
  //   data['n_ano_ocupacao'] = nAnoOcupacao;
  //   data['n_ocupacao_alta_temporada'] = nOcupacaoAltaTemporada;
  //   data['n_total_de_uh'] = nTotalDeUH;
  //   data['n_total_de_leitos'] = nTotalDeLeitos;
  //   data['n_uh_adaptadas_para_pcd'] = nUhAdaptadasParaPCD;
  //   data['n_capacidade_de_veiculos'] = nCapacidadeDeVeiculos;
  //   data['n_automoveis'] = nAutomoveis;
  //   data['n_onibus'] = nOnibus;
  //   data['capacidade_em_kva'] = capacidadeEmKVA;
  //   data['gerador_capacidade_em_kva'] = geradorCapacidadeEmKVA;
  //   data['n_capacidade_instalada_por_dia'] = nCapacidadeInstaladaPorDia;
  //   data['n_pessoas_atendidas_sentadas'] = nPessoasAtendidasSentadas;
  //   data['n_capacidade_simultanea'] = nCapacidadeSimultanea;
  //   data['n_pessoas_atendidas_sentadas_simultanea'] =
  //       nPessoasAtendidasSentadasSimultanea;
  //   data['lanchonete_capacidade_instalada_por_dia'] =
  //       lanchoneteCapacidadeInstaladaPorDia;
  //   data['lanchonete_capacidade_pessoas_atendidas_sentadas'] =
  //       lanchoneteCapacidadePessoasAtendidasSentadas;
  //   data['lanchonete_capacidade_simultanea'] = lanchoneteCapacidadeSimultanea;
  //   data['lanchonete_capacidade_sentadas_simultanea'] =
  //       lanchoneteCapacidadeSentadasSimultanea;
  //   data['tabela_instalacoes'] = tabelaInstalacoes;
  //   data['tabela_equipamento_e_espaco'] = tabelaEquipamentoEEspaco;
  //   data['tabela_equipamento_e_espaco_2'] = tabelaEquipamentoEEspaco2;
  //   data['outros'] = outros;
  //   data['outrasAcessibilidade'] = outrasAcessibilidade;
  //   return data;
  // }
}
