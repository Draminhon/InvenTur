class EntidadesAssociativasModel {
  int? id;
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
  String? inicioDaAtividade;

  // Dados de quantitativos e capacidade
  String? qtdeFuncionariosPermanentes;
  String? qtdeFuncionariosTemporarios;
  String? qtdeFuncionarisComDeficiencia;
  String? latitude;
  String? longitude;
//---------------------------------//
  String? nomeDoDirigente;
  String? cargo;
  String? representacaoSetor;
  String? numeroDeAssociados;
  String? abrangencia;
  String? representividade;
  String? CNPJ;

  String? forum;
  String? conselho;
  String? federecao;
  String? associacao;
  String? outrosEntidade;



String? distanciasAeroporto;
  String? distanciasRodoviaria;
  String? distanciaEstacaoFerroviaria;
  String? distanciaEstacaoMaritima;
  String? distanciaEstacaoMetroviaria;
  String? distanciaPontoDeOnibus;
  String? distanciaPontoDeTaxi;
  String? distanciasOutraNome;
  String? distanciaOutras;
//--------------------------------//
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
  EntidadesAssociativasModel({
    this.id,
    this.tipoFormulario,
    this.abrangencia,
    this.uf,
    this.regiaoTuristica,
    this.municipio,
    this.tipo,
    this.ambientacaoTematica,
    this.observacoes,
    this.permissaoDeAcesso,
    
  this.forum,
  this.conselho,
  this.federecao,
  this.associacao,
  this.outrosEntidade,
    this.nomeDoDirigente,
    this.cargo,
    this.representividade,
    this.representacaoSetor,
    this.referencias,
    this.nomePesquisador,
    this.numeroDeAssociados,
    this.telefonePesquisador,
    this.entidadeManetedora,
    this.entidadeManetedoraEmail,
    this.entidadeManetedoraSite,
    this.entradaGratuita,
    this.entradaPaga,
    this.emailPesquisador,
    this.CNPJ,
    this.nomeCoordenador,
    this.telefoneCoordenador,
    this.emailCoordenador,
    this.sinalizacaoDeAcesso,
    this.sinalizacaoTuristica,
        this.distanciasAeroporto,
    this.distanciasRodoviaria,
    this.distanciaEstacaoFerroviaria,
    this.distanciaEstacaoMaritima,
    this.distanciaEstacaoMetroviaria,
    this.distanciaPontoDeOnibus,
    this.distanciaPontoDeTaxi,
    this.distanciasOutraNome,
    this.distanciaOutras,
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
      'tipo_formulario': tipoFormulario,
      'uf': uf,
      'representividade': representividade,
      'permissaoDeAcesso': permissaoDeAcesso,
      'regiao_turistica': regiaoTuristica,
      'municipio': municipio,
      'tipo': tipo,
      
 'forum': forum,
 'conselho': conselho,
 'federecao': federecao,
 'associacao': associacao,
 'outrosEntidade': outrosEntidade,
      'numeroDeAssociados': numeroDeAssociados,
      'observacoes': observacoes,
      'referencias': referencias,
      'entradaGratuita': entradaGratuita,
      'entradaPaga': entradaPaga,
      'nomeDoDirigente': nomeDoDirigente,
    'cargo': cargo,
    'abrangencia': abrangencia,
    'CNPJ': CNPJ,
    'representacaoSetor': representacaoSetor,
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
          'distanciasAeroporto': distanciasAeroporto,
    'distanciasRodoviaria': distanciasRodoviaria,
    'distanciaEstacaoFerroviaria': distanciaEstacaoFerroviaria,
    'distanciaEstacaoMaritima': distanciaEstacaoMaritima,
    'distanciaEstacaoMetroviaria': distanciaEstacaoMetroviaria,
    'distanciaPontoDeOnibus': distanciaPontoDeOnibus,
    'distanciaPontoDeTaxi': distanciaPontoDeTaxi,
    'distanciasOutraNome': distanciasOutraNome,
    'distanciaOutras': distanciaOutras,
    };
  }

  EntidadesAssociativasModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoFormulario = json['tipo_formulario'];
    uf = json['uf'];
    CNPJ = json['CNPJ'];
    
   forum = json['forum'];
   conselho = json['conselho'];
   federecao = json['federacao'];
   associacao = json['associacao'];
   outrosEntidade = json['outrosEntidade'];
    proximidades = List<String>.from(json['proximidades'] ?? []);
    distanciasAeroporto = json['distanciasAeroporto'];
    distanciasRodoviaria = json['distanciasRodoviaria'];
    distanciaEstacaoFerroviaria = json['distanciaEstacaoFerroviaria'];
    distanciaEstacaoMaritima = json['distanciaEstacaoMaritima'];
    distanciaEstacaoMetroviaria = json['distanciaEstacaoMetroviaria'];
    distanciaPontoDeOnibus = json['distanciaPontoDeOnibus'];
    distanciaPontoDeTaxi = json['distanciaPontoDeTaxi'];
    distanciasOutraNome = json['distanciasOutraNome'];
    distanciaOutras = json['distanciaOutras'];
    representividade = json['representividade'];
    abrangencia = json['abrangencia'];
    nomeDoDirigente = json['nomeDoDirigente'];
    cargo = json['cargo'];
    representacaoSetor = json['representacaoSetor'];
numeroDeAssociados = json['numeroDeAssociados'];
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

}
