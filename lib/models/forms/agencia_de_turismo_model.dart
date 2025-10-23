class AgenciasDeTurismoModel {
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
  List<String>? mesesAltaTemporada;
  String? anoBaseEmissivos;
  List<String>? mesesBaixaTemporada;
  String? vendasAltaTemporada;
  List<String>? segmentosEspecializado;
  String? razaoSocial;
  List<String>? destinosEmissivosNacionais;
  List<String>? destinosEmissivosInternacionais;
  List<String>? origemEmissivosNacionais;
  List<String>? origemEmissivosInternacionais;
  String? totalVendasEmissivos;
  String? totalVendasReceptivos;
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

  List<String>? bilhetesTerrestres;
  List<String>? bilhetesAereos;
  List<String>? pacotesTuristicos;
  List<String>? cruzeirosMaritimos;
  List<String>? meiosDeHospedagem;
  List<String>? servicosTraslados;
  List<String>? seguroDeViagem;
  List<String>? locacaoDeAutomoveis;
  String? servicosBasicosOutros;
  String? apoioADespachos;
  List<String>? servicosEAtividadesEspecializadas;
  String? transporteTerrestre;
  String? aumovelDePasseio;
  String? buggy;
  String? motocicleta;
  String? caminhao;
  String? caminhonete;
  String? onibus;
  String? utilitario;
  String? trem;
  String? outrosTipoVeiculo;
  String? totalDeVeiculos;
  String? totalDeVeiculosAdaptados;
  List<String>? tipoDeServico;
  String? transporteAquatico;
  String? iate;
  String? chalana ;
  String? navio ;
  String? saveiro ;
  String? escuna ;
  String? jangada  ;
  String? traineira ;
  String? catarama ;
  String? veleiro ;
  String? ferryBoat ;
  String?  lancha;
  String? outrosEmbarcacao;
String? totalDeVeiculosAquaticos;
String? totalDeVeiculosAquaticosAdaptados;
List<String>? tipoDeServicoAquatico;
String? caracterizacaoServico;
String? transporteAereo;
String? helicoptero;
String? aviao;
String? outrosAeronave;
String? totalDeVeiculosAeronaves;
String? totalDeVeiculosAeronavesAdaptados;
List<String>? tipoDeServicoAeronave;


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
  List<String>? atendimentoEmLinguasEstrangeiras;
  List<String>? informativosImpressos;
  List<String>? periodo;
  Map<String, dynamic>? tabelasHorario;
  String? funcionamento24h;
  String? funcionamentoEmFeriados;
  String? outrasRegrasEInformacoes;
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

  AgenciasDeTurismoModel({
    this.id,
    this.segmentosEspecializado,
    this.tipoFormulario,
    this.vendasAltaTemporada,
    this.anoBaseEmissivos,
    this.mesesBaixaTemporada,
    this.mesesAltaTemporada,
    this.uf,
    this.destinosEmissivosNacionais,
    this.destinosEmissivosInternacionais,
    this.regiaoTuristica,
    this.municipio,
    this.totalVendasEmissivos,
    this.totalVendasReceptivos,
    this.origemEmissivosInternacionais,
    this.origemEmissivosNacionais,
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
    this.atendimentoEmLinguasEstrangeiras,
    this.informativosImpressos,
    this.periodo,
    this.tabelasHorario,
    this.funcionamento24h,
    this.funcionamentoEmFeriados,
    this.outrasRegrasEInformacoes,
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

AgenciasDeTurismoModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  tipoFormulario = json['tipoFormulario'];
  uf = json['uf'];
  vendasAltaTemporada = json['vendasAltaTemporada'];
  totalVendasEmissivos = json['totalVendasEmissivos'];
  regiaoTuristica = json['regiao_turistica'];
  totalVendasReceptivos = json['totalVendasReceptivos'];
  anoBaseEmissivos = json['anoBaseEmissivos'];
  origemEmissivosInternacionais = json['origemEmissivosInternacionais'];
  origemEmissivosNacionais = json['origemEmissivosNacionais'];
  municipio = json['municipio'];
  tipo = json['tipo'];
  destinosEmissivosNacionais = json['destinosEmissivosNacionais'];
  destinosEmissivosInternacionais = json['destinosEmissivosInternacionais'];
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
  mesesBaixaTemporada = List<String>.from(json['mesesBaixaTemporada'] ?? []);
  mesesAltaTemporada = List<String>.from(json['mesesAltaTemporada'] ?? []);
  segmentosEspecializado = List<String>.from(json['segmentosEspecializado'] ?? []);
  tabelaMTUR = Map<String, dynamic>.from(json['tabelaMTUR'] ?? {});
  formasDePagamento = List<String>.from(json['formasDePagamento'] ?? []);
  atendimentoEmLinguasEstrangeiras = List<String>.from(json['atendimentoEmLinguasEstrangeiras'] ?? []);
  informativosImpressos = List<String>.from(json['informativosImpressos'] ?? []);
  periodo = List<String>.from(json['periodo'] ?? []);
  tabelasHorario = Map<String, dynamic>.from(json['tabelasHorario'] ?? {});
  funcionamento24h = json['funcionamento24h'];
  funcionamentoEmFeriados = json['funcionamentoEmFeriados'];
  outrasRegrasEInformacoes = json['outrasRegrasEInformacoes'];
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
    'anoBaseEmissivos': anoBaseEmissivos,
    'totalVendasEmissivos': totalVendasEmissivos,
    'tipo_formulario': tipoFormulario,
    'uf': uf,
    'mesesBaixaTemporada': mesesBaixaTemporada,

    'mesesAltaTemporada': mesesAltaTemporada,
    'vendasAltaTemporada': vendasAltaTemporada,
    'destinosEmissivosNacionais': destinosEmissivosNacionais,
    'destinosEmissivosInternacionais':destinosEmissivosInternacionais,
    'regiao_turistica': regiaoTuristica,
    'municipio': municipio,
    'tipo': tipo,
    'observacoes': observacoes,
    'referencias': referencias,
    'nomePesquisador': nomePesquisador,
    'telefonePesquisador': telefonePesquisador,
    'emailPesquisador': emailPesquisador,
    'nomeCoordenador': nomeCoordenador,
    'totalVendasReceptivos':totalVendasReceptivos,
    'origemEmissivosInternacionais': origemEmissivosInternacionais,
    'origemEmissivosNacionais': origemEmissivosNacionais,
    'telefoneCoordenador': telefoneCoordenador,
    'emailCoordenador': emailCoordenador,
    'razaoSocial': razaoSocial,
    'nomeFantasia': nomeFantasia,
    'segmentosEspecializado':segmentosEspecializado,
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
    'atendimentoEmLinguasEstrangeiras': atendimentoEmLinguasEstrangeiras,
    'informativosImpressos': informativosImpressos,
    'periodo': periodo,
    'tabelasHorario': tabelasHorario,
    'funcionamento24h': funcionamento24h,
    'funcionamentoEmFeriados': funcionamentoEmFeriados,
    'outrasRegrasEInformacoes': outrasRegrasEInformacoes,
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