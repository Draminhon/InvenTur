class AlimentosEBebidasModel {
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

  String? razaoSocial;
  String? nomeFantasia;
  String? CNPJ;
  String? codigoCNAE;
  String? atividadeEconomica;
  String? inscricaoMunicipal;
  String? nomeDaRede;
  String? natureza;
  List<String>? tipoDeOrganizacaoInstituicao;
  String? inicioDaAtividade;
  String? qtdeFuncionariosPermanentes;
  String? qtdeFuncionariosTemporarios;
  String? qtdeFuncionariosComDeficiencia;
  String? localizacao;
  String? latitude;
  String? longitude;
  String? avenidaRuaEtc;
  String? bairroLocalidade;
  String? distrito;
  String? CEP;
  String? whatsapp;
  String? instagram;
  String? email;
  String? sinalizacaoDeAcesso;
  String? sinalizacaoTuristica;
  List<String>? proximidades;
  String? distanciasAeroporto;
  String? distanciasRodoviaria;
  String? distanciaEstacaoFerroviaria;
  String? distanciaEstacaoMaritima;
  String? distanciaEstacaoMetroviaria;
  String? distanciaPontoDeOnibus;
  String? distanciaPontoDeTaxi;
  String? distanciasOutraNome;
  String? distanciaOutras;
  String? pontosDeReferencia;
  Map<String, dynamic>? tabelaMTUR;
  List<String>? formasDePagamento;
  List<String>? vendasEReservas;
  List<String>? atendimentoEmLinguasEstrangeiras;
  List<String>? informativosImpressos;
  List<String>? periodo;
  Map<String, dynamic>? tabelasHorario;
  String? funcionamento24h;
  String? funcionamentoEmFeriados;
  List<String>? restricoes;
  String? outrasRegrasEInformacoes;
  String? capInstaladaPdia;
  String? capInstaladasSentadas;
  String? capSimultanea;
  String? capSimultaneaSentadas;
  List<String>? estacionamento;
  String? capacidadeVeiculos;
  String? numeroAutomoveis;
  String? numeroOnibus;
  List<String>? servicosEEquipamentos;
  List<String>? especificacaoDaGastronomiaPorPais;
  List<String>? seForBrasileiraPorRegiao;
  List<String>? porEspecializacao;
  List<String>? porTipoDeDieta;
  List<String>? porTipoDeServico;
  String? doEquipamento;
  String? areaOuEdificacao;
  Map<String, dynamic>? tabelaEquipamentoEEspaco;
  Map<String, dynamic>? tabelaAreaOuEdificacao;

  String? estadoGeralDeConservacao;
  String? possuiFacilidade;
  List<String>? pessoalCapacitadoParaReceberPCD;
  List<String>? rotaExternaAcessivel;
  List<String>? simboloInternacionalDeAcesso;
  List<String>? localDeEmbarqueEDesembarque;
  List<String>? vagaEmEstacionamento;
  List<String>? areaDeCirculacaoAcessoInternoParaCadeiraDeRodas;
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
  String? sinalizacaoIndicativa;
  String? outrosAcessibilidade;

  AlimentosEBebidasModel({
    this.id,
    this.usuario_criador,
    this.tipoFormulario,
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
    this.razaoSocial,
    this.nomeFantasia,
    this.CNPJ,
    this.codigoCNAE,
    this.atividadeEconomica,
    this.inscricaoMunicipal,
    this.nomeDaRede,
    this.natureza,
    this.tipoDeOrganizacaoInstituicao,
    this.inicioDaAtividade,
    this.qtdeFuncionariosPermanentes,
    this.qtdeFuncionariosTemporarios,
    this.qtdeFuncionariosComDeficiencia,
    this.localizacao,
    this.latitude,
    this.longitude,
    this.avenidaRuaEtc,
    this.bairroLocalidade,
    this.distrito,
    this.CEP,
    this.whatsapp,
    this.instagram,
    this.email,
    this.sinalizacaoDeAcesso,
    this.sinalizacaoTuristica,
    this.proximidades,
    this.distanciasAeroporto,
    this.distanciasRodoviaria,
    this.distanciaEstacaoFerroviaria,
    this.distanciaEstacaoMaritima,
    this.distanciaEstacaoMetroviaria,
    this.distanciaPontoDeOnibus,
    this.distanciaPontoDeTaxi,
    this.distanciasOutraNome,
    this.distanciaOutras,
    this.pontosDeReferencia,
    this.tabelaMTUR,
    this.tabelaAreaOuEdificacao,
    this.areaOuEdificacao,
    this.formasDePagamento,
    this.vendasEReservas,
    this.atendimentoEmLinguasEstrangeiras,
    this.informativosImpressos,
    this.periodo,
    this.tabelasHorario,
    this.funcionamento24h,
    this.funcionamentoEmFeriados,
    this.restricoes,
    this.outrasRegrasEInformacoes,
    this.capInstaladaPdia,
    this.capInstaladasSentadas,
    this.capSimultanea,
    this.capSimultaneaSentadas,
    this.estacionamento,
    this.capacidadeVeiculos,
    this.numeroAutomoveis,
    this.numeroOnibus,
    this.servicosEEquipamentos,
    this.especificacaoDaGastronomiaPorPais,
    this.seForBrasileiraPorRegiao,
    this.porEspecializacao,
    this.porTipoDeDieta,
    this.porTipoDeServico,
    this.doEquipamento,
    this.tabelaEquipamentoEEspaco,
    this.estadoGeralDeConservacao,
    this.possuiFacilidade,
    this.pessoalCapacitadoParaReceberPCD,
    this.rotaExternaAcessivel,
    this.simboloInternacionalDeAcesso,
    this.localDeEmbarqueEDesembarque,
    this.vagaEmEstacionamento,
    this.areaDeCirculacaoAcessoInternoParaCadeiraDeRodas,
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
    this.sinalizacaoIndicativa,
    this.outrosAcessibilidade,
  });

AlimentosEBebidasModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  usuario_criador = json['usuario_criador'];
  tipoFormulario = json['tipoFormulario'];
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
  razaoSocial = json['razaoSocial'];
  nomeFantasia = json['nomeFantasia'];
  CNPJ = json['CNPJ'];
  codigoCNAE = json['codigoCNAE'];
  atividadeEconomica = json['atividadeEconomica'];
  inscricaoMunicipal = json['inscricaoMunicipal'];
  nomeDaRede = json['nomeDaRede'];
  natureza = json['natureza'];
  tipoDeOrganizacaoInstituicao = List<String>.from(json['tipoDeOrganizacaoInstituicao'] ?? []);
  inicioDaAtividade = json['inicioDaAtividade'];
  qtdeFuncionariosPermanentes = json['qtdeFuncionariosPermanentes'];
  qtdeFuncionariosTemporarios = json['qtdeFuncionariosTemporarios'];
  qtdeFuncionariosComDeficiencia = json['qtdeFuncionariosComDeficiencia'];
  localizacao = json['localizacao'];
  latitude = json['latitude'];
  longitude = json['longitude'];
  avenidaRuaEtc = json['avenidaRuaEtc'];
  bairroLocalidade = json['bairroLocalidade'];
  distrito = json['distrito'];
  CEP = json['CEP'];
  whatsapp = json['whatsapp'];
  instagram = json['instagram'];
  email = json['email'];
  sinalizacaoDeAcesso = json['sinalizacaoDeAcesso'];
  sinalizacaoTuristica = json['sinalizacaoTuristica'];
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
  pontosDeReferencia = json['pontosDeReferencia'];
  tabelaMTUR = Map<String, dynamic>.from(json['tabelaMTUR'] ?? {});
  formasDePagamento = List<String>.from(json['formasDePagamento'] ?? []);
  vendasEReservas = List<String>.from(json['vendasEReservas'] ?? []);
  atendimentoEmLinguasEstrangeiras = List<String>.from(json['atendimentoEmLinguasEstrangeiras'] ?? []);
  informativosImpressos = List<String>.from(json['informativosImpressos'] ?? []);
  periodo = List<String>.from(json['periodo'] ?? []);
  tabelasHorario = Map<String, dynamic>.from(json['tabelasHorario'] ?? {});
  funcionamento24h = json['funcionamento24h'];
  funcionamentoEmFeriados = json['funcionamentoEmFeriados'];
  restricoes = List<String>.from(json['restricoes'] ?? []);
  outrasRegrasEInformacoes = json['outrasRegrasEInformacoes'];
  capInstaladaPdia = json['capInstaladaPdia'];
  capInstaladasSentadas = json['capInstaladasSentadas'];
  capSimultanea = json['capSimultanea'];
  capSimultaneaSentadas = json['capSimultaneaSentadas'];
  estacionamento = List<String>.from(json['estacionamento'] ?? []);
  capacidadeVeiculos = json['capacidadeVeiculos'];
  numeroAutomoveis = json['numeroAutomoveis'];
  numeroOnibus = json['numeroOnibus'];
  servicosEEquipamentos = List<String>.from(json['servicosEEquipamentos'] ?? []);
  especificacaoDaGastronomiaPorPais = List<String>.from(json['especificacaoDaGastronomiaPorPais'] ?? []);
  seForBrasileiraPorRegiao = List<String>.from(json['seForBrasileiraPorRegiao'] ?? []);
  porEspecializacao = List<String>.from(json['porEspecializacao'] ?? []);
  porTipoDeDieta = List<String>.from(json['porTipoDeDieta'] ?? []);
  porTipoDeServico = List<String>.from(json['porTipoDeServico'] ?? []);
  doEquipamento = json['doEquipamento'];
  areaOuEdificacao = json['areaOuEdificacao'];
  tabelaAreaOuEdificacao = Map<String, dynamic>.from(json['tabelaAreaOuEdificacao'] ?? {});
  tabelaEquipamentoEEspaco = Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco'] ?? {});
  
  estadoGeralDeConservacao = json['estadoGeralDeConservacao'];
  possuiFacilidade = json['possuiFacilidade'];
  pessoalCapacitadoParaReceberPCD = List<String>.from(json['pessoalCapacitadoParaReceberPCD'] ?? []);
  rotaExternaAcessivel = List<String>.from(json['rotaExternaAcessivel'] ?? []);
  simboloInternacionalDeAcesso = List<String>.from(json['simboloInternacionalDeAcesso'] ?? []);
  localDeEmbarqueEDesembarque = List<String>.from(json['localDeEmbarqueEDesembarque'] ?? []);
  vagaEmEstacionamento = List<String>.from(json['vagaEmEstacionamento'] ?? []);
  areaDeCirculacaoAcessoInternoParaCadeiraDeRodas = List<String>.from(json['areaDeCirculacaoAcessoInternoParaCadeiraDeRodas'] ?? []);
  escada = List<String>.from(json['escada'] ?? []);
  rampa = List<String>.from(json['rampa'] ?? []);
  piso = List<String>.from(json['piso'] ?? []);
  elevador = List<String>.from(json['elevador'] ?? []);
  equipamentoMotorizadoParaDeslocamentoInterno = List<String>.from(json['equipamentoMotorizadoParaDeslocamentoInterno'] ?? []);
  sinalizacaoVisual = List<String>.from(json['sinalizacaoVisual'] ?? []);
  sinalizacaoTatil = List<String>.from(json['sinalizacaoTatil'] ?? []);
  alarmeDeEmergencia = List<String>.from(json['alarmeDeEmergencia'] ?? []);
  comunicacao = List<String>.from(json['comunicacao'] ?? []);
  balcaoDeAtendimento = List<String>.from(json['balcaoDeAtendimento'] ?? []);
  mobiliario = List<String>.from(json['mobiliario'] ?? []);
  sanitario = List<String>.from(json['sanitario'] ?? []);
  telefone = List<String>.from(json['telefone'] ?? []);
  sinalizacaoIndicativa = json['sinalizacaoIndicativa'];
  outrosAcessibilidade = json['outrosAcessibilidade'];
}

Map<String, dynamic> toMap() {
   return{
    'id': id,
    'usuario_criador': usuario_criador,
    'tipo_formulario': tipoFormulario,
    'uf': uf,
    'regiao_turistica': regiaoTuristica,
    'municipio': municipio,
    'tipo': tipo,
    'observacoes': observacoes,
    'referencias': referencias,
    'nomePesquisador': nomePesquisador,
    'telefonePesquisador': telefonePesquisador,
    'emailPesquisador': emailPesquisador,
    'nomeCoordenador': nomeCoordenador,
    'telefoneCoordenador': telefoneCoordenador,
    'emailCoordenador': emailCoordenador,
    'razaoSocial': razaoSocial,
    'nomeFantasia': nomeFantasia,
    'CNPJ': CNPJ,
    'codigoCNAE': codigoCNAE,
    'atividadeEconomica': atividadeEconomica,
    'inscricaoMunicipal': inscricaoMunicipal,
    'nomeDaRede': nomeDaRede,
    'natureza': natureza,
    'tipoDeOrganizacaoInstituicao': tipoDeOrganizacaoInstituicao,
    'inicioDaAtividade': inicioDaAtividade,
    'qtdeFuncionariosPermanentes': qtdeFuncionariosPermanentes,
    'qtdeFuncionariosTemporarios': qtdeFuncionariosTemporarios,
    'qtdeFuncionariosComDeficiencia': qtdeFuncionariosComDeficiencia,
    'localizacao': localizacao,
    'latitude': latitude,
    'longitude': longitude,
    'avenidaRuaEtc': avenidaRuaEtc,
    'bairroLocalidade': bairroLocalidade,
    'distrito': distrito,
    'CEP': CEP,
    'whatsapp': whatsapp,
    'instagram': instagram,
    'email': email,
    'sinalizacaoDeAcesso': sinalizacaoDeAcesso,
    'sinalizacaoTuristica': sinalizacaoTuristica,
    'proximidades': proximidades,
    'distanciasAeroporto': distanciasAeroporto,
    'distanciasRodoviaria': distanciasRodoviaria,
    'distanciaEstacaoFerroviaria': distanciaEstacaoFerroviaria,
    'distanciaEstacaoMaritima': distanciaEstacaoMaritima,
    'distanciaEstacaoMetroviaria': distanciaEstacaoMetroviaria,
    'distanciaPontoDeOnibus': distanciaPontoDeOnibus,
    'distanciaPontoDeTaxi': distanciaPontoDeTaxi,
    'distanciasOutraNome': distanciasOutraNome,
    'distanciaOutras': distanciaOutras,
    'pontosDeReferencia': pontosDeReferencia,
    'tabelaMTUR': tabelaMTUR,
    'formasDePagamento': formasDePagamento,
    'vendasEReservas': vendasEReservas,
    'atendimentoEmLinguasEstrangeiras': atendimentoEmLinguasEstrangeiras,
    'informativosImpressos': informativosImpressos,
    'periodo': periodo,
    'tabelasHorario': tabelasHorario,
    'funcionamento24h': funcionamento24h,
    'funcionamentoEmFeriados': funcionamentoEmFeriados,
    'restricoes': restricoes,
    'outrasRegrasEInformacoes': outrasRegrasEInformacoes,
    'capInstaladaPdia': capInstaladaPdia,
    'capInstaladasSentadas': capInstaladasSentadas,
    'capSimultanea': capSimultanea,
    'capSimultaneaSentadas': capSimultaneaSentadas,
    'estacionamento': estacionamento,
    'capacidadeVeiculos': capacidadeVeiculos,
    'numeroAutomoveis': numeroAutomoveis,
    'numeroOnibus': numeroOnibus,
    'servicosEEquipamentos': servicosEEquipamentos,
    'especificacaoDaGastronomiaPorPais': especificacaoDaGastronomiaPorPais,
    'seForBrasileiraPorRegiao': seForBrasileiraPorRegiao,
    'porEspecializacao': porEspecializacao,
    'porTipoDeDieta': porTipoDeDieta,
    'porTipoDeServico': porTipoDeServico,
    'doEquipamento': doEquipamento,
    'areaOuEdificacao': areaOuEdificacao,
    'tabelaEquipamentoEEspaco': tabelaEquipamentoEEspaco,
    'tabelaAreaOuEdificacao': tabelaAreaOuEdificacao,
    'estadoGeralDeConservacao': estadoGeralDeConservacao,
    'possuiFacilidade': possuiFacilidade,
    'pessoalCapacitadoParaReceberPCD': pessoalCapacitadoParaReceberPCD,
    'rotaExternaAcessivel': rotaExternaAcessivel,
    'simboloInternacionalDeAcesso': simboloInternacionalDeAcesso,
    'localDeEmbarqueEDesembarque': localDeEmbarqueEDesembarque,
    'vagaEmEstacionamento': vagaEmEstacionamento,
    'areaDeCirculacaoAcessoInternoParaCadeiraDeRodas': areaDeCirculacaoAcessoInternoParaCadeiraDeRodas,
    'escada': escada,
    'rampa': rampa,
    'piso': piso,
    'elevador': elevador,
    'equipamentoMotorizadoParaDeslocamentoInterno': equipamentoMotorizadoParaDeslocamentoInterno,
    'sinalizacaoVisual': sinalizacaoVisual,
    'sinalizacaoTatil': sinalizacaoTatil,
    'alarmeDeEmergencia': alarmeDeEmergencia,
    'comunicacao': comunicacao,
    'balcaoDeAtendimento': balcaoDeAtendimento,
    'mobiliario': mobiliario,
    'sanitario': sanitario,
    'telefone': telefone,
    'sinalizacaoIndicativa': sinalizacaoIndicativa,
    'outrosAcessibilidade': outrosAcessibilidade,
   };
  }
} 