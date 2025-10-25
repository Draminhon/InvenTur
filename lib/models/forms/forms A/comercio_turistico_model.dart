class ComercioTuristicoModel {
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
  String? sinalizacaoDeAcesso;
  String? sinalizacaoTuristica;
  List<String>? subtipo;
  String? natureza;
  String? tipoDeOrganizacao;
  String? localizacao;
  String? razaoSocial;
  String? nomeFantasia;
  String? cNPJ;
  String? codigoCNAE;
  String? atividadeEconomica;
  String? inscricaoMunicipal;
  String? nomeDaRedeFranquia;
  String? longitude;
  String? latitude;
  String? avenidaRuaTravessa;
  String? bairroLocalidade;
  String? distrito;
  String? cEP;
  String? whatsapp;
  String? instagram;
  String? email;
  String? site;
  String? pontosDeReferencia;
  String? outrasRegrasEInformacoes;
  String? capacidadeDeVeiculos;
  String? automoveis;
  String? onibus;
  String? outrasAcessibilidade;
  String? funcionamento24h;
  String? funcionamentoEmFeriados;
  List<String>? formasDePagamento;
  String? atendimentoEmLinguaEstrangeira;
  List<String>? informativosImpressos;
  List<String>? regrasDeFuncionamentoPeriodo;  
  String? estacionamento;
  List<String>? produtosEServicos;
  List<String>? outrosServicos;
  String? doEquipamentoEspaco;
  String? areaOuEdificacaoEmQueEstaInstalado;
  String? possuiFacilidade;
  String? estadoGeralConservacao;
  String? sinalizacaoIndicativaPreferencial;
  List<String>? pessoalCapacitado;
  List<String>? rotaExternaAcessivel;
  List<String>? simboloInternacionalDeAcesso;
  List<String>? localDeEmbarqueEDesembarque;
  List<String>? vagaEmEstacionamento;
  List<String>? areaDeCirculacao;
  List<String>? escada;
  List<String>? rampa;
  List<String>? piso;
  List<String>? elevador;
  List<String>? equipamentoMotorizado;
  List<String>? sinalizacaoVisual;
  List<String>? sinalizacaoTatil;
  List<String>? alarmeDeEmergencia;
  List<String>? comunicacao;
  List<String>? balcaoDeAtendimento;
  List<String>? mobiliario;
  List<String>? sanitario;
  List<String>? telefone;
  Map<String, dynamic>? tabelEquipamentoEEspaco;
  Map<String, dynamic>? tabelaAreaOuEdificacao;
  Map<String, dynamic>? tabelaHorarios;

  ComercioTuristicoModel(
      {
            this.id,
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
        this.sinalizacaoDeAcesso,
      this.sinalizacaoTuristica,
      this.subtipo,
      this.natureza,
      this.tipoDeOrganizacao,
      this.localizacao,
      this.razaoSocial,
      this.nomeFantasia,
      this.cNPJ,
      this.codigoCNAE,
      this.atividadeEconomica,
      this.inscricaoMunicipal,
      this.nomeDaRedeFranquia,
      this.longitude,
      this.latitude,
      this.avenidaRuaTravessa,
      this.bairroLocalidade,
      this.distrito,
      this.cEP,
      this.whatsapp,
      this.instagram,
      this.email,
      this.site,
      this.pontosDeReferencia,
      this.outrasRegrasEInformacoes,
      this.capacidadeDeVeiculos,
      this.automoveis,
      this.onibus,
      this.outrasAcessibilidade,
      this.funcionamento24h,
      this.funcionamentoEmFeriados,
      this.formasDePagamento,
      this.atendimentoEmLinguaEstrangeira,
      this.informativosImpressos,
      this.regrasDeFuncionamentoPeriodo,
      this.estacionamento,
      this.produtosEServicos,
      this.outrosServicos,
      this.doEquipamentoEspaco,
      this.areaOuEdificacaoEmQueEstaInstalado,
      this.possuiFacilidade,
      this.estadoGeralConservacao,
      this.sinalizacaoIndicativaPreferencial,
      this.pessoalCapacitado,
      this.rotaExternaAcessivel,
      this.simboloInternacionalDeAcesso,
      this.localDeEmbarqueEDesembarque,
      this.vagaEmEstacionamento,
      this.areaDeCirculacao,
      this.escada,
      this.rampa,
      this.piso,
      this.elevador,
      this.equipamentoMotorizado,
      this.sinalizacaoVisual,
      this.sinalizacaoTatil,
      this.alarmeDeEmergencia,
      this.comunicacao,
      this.balcaoDeAtendimento,
      this.mobiliario,
      this.sanitario,
      this.telefone,
      this.tabelEquipamentoEEspaco,
      this.tabelaAreaOuEdificacao,
      this.tabelaHorarios});


  Map<String, dynamic> toMap(){
    return{
          'tipo_formulario': this.tipoFormulario,
    'uf': this.uf,
    'regiao_turistica': this.regiaoTuristica,
    'municipio': this.municipio,
    'tipo': this.tipo,
    'observacoes': this.observacoes,
    'referencias': this.referencias,
    'nome_pesquisador': this.nomePesquisador,
    'telefone_pesquisador': this.telefonePesquisador,
    'email_pesquisador': this.emailPesquisador,
    'nome_coordenador': this.nomeCoordenador,
    'telefone_coordenador': this.telefoneCoordenador,
    'email_coordenador': this.emailCoordenador,
   'sinalizacaoDeAcesso' : this.sinalizacaoDeAcesso,
   'sinalizacaoTuristica' : this.sinalizacaoTuristica,
   'subtipo' : this.subtipo,
   'natureza' : this.natureza,
   'tipoDeOrganizacao' : this.tipoDeOrganizacao,
   'localizacao' : this.localizacao,
   'razaoSocial' : this.razaoSocial,
   'nomeFantasia' : this.nomeFantasia,
   'CNPJ' : this.cNPJ,
   'codigoCNAE' : this.codigoCNAE,
   'atividadeEconomica' : this.atividadeEconomica,
   'inscricaoMunicipal' : this.inscricaoMunicipal,
   'nomeDaRedeFranquia' : this.nomeDaRedeFranquia,
   'longitude' : this.longitude,
   'latitude' : this.latitude,
   'avenidaRuaTravessa' : this.avenidaRuaTravessa,
   'bairroLocalidade' : this.bairroLocalidade,
   'distrito' : this.distrito,
   'CEP' : this.cEP,
   'whatsapp' : this.whatsapp,
   'instagram' : this.instagram,
   'email' : this.email,
   'site' : this.site,
   'pontosDeReferencia' : this.pontosDeReferencia,
   'outrasRegrasEInformacoes' : this.outrasRegrasEInformacoes,
   'capacidadeDeVeiculos' : this.capacidadeDeVeiculos,
   'automoveis' : this.automoveis,
   'onibus' : this.onibus,
   'outrasAcessibilidade' : this.outrasAcessibilidade,
   'funcionamento24h' : this.funcionamento24h,
   'funcionamentoEmFeriados' : this.funcionamentoEmFeriados,
   'formasDePagamento' : this.formasDePagamento,
   'atendimentoEmLinguaEstrangeira' :
        this.atendimentoEmLinguaEstrangeira,
   'informativosImpressos' : this.informativosImpressos,
   'regrasDeFuncionamentoPeriodo' : this.regrasDeFuncionamentoPeriodo,
   'estacionamento' : this.estacionamento,
   'produtosEServicos' : this.produtosEServicos,
   'outrosServicos' : this.outrosServicos,
   'doEquipamentoEspaco' : this.doEquipamentoEspaco,
   'areaOuEdificacaoEmQueEstaInstalado' :
        this.areaOuEdificacaoEmQueEstaInstalado,
   'possuiFacilidade' : this.possuiFacilidade,
   'estadoGeralConservacao' : this.estadoGeralConservacao,
   'sinalizacaoIndicativaPreferencial' :
        this.sinalizacaoIndicativaPreferencial,
   'pessoalCapacitado' : this.pessoalCapacitado,
   'rotaExternaAcessivel' : this.rotaExternaAcessivel,
   'simboloInternacionalDeAcesso' : this.simboloInternacionalDeAcesso,
   'localDeEmbarqueEDesembarque' : this.localDeEmbarqueEDesembarque,
   'vagaEmEstacionamento' : this.vagaEmEstacionamento,
   'areaDeCirculacao' : this.areaDeCirculacao,
   'escada' : this.escada,
   'rampa' : this.rampa,
   'piso' : this.piso,
   'elevador' : this.elevador,
   'equipamentoMotorizado' : this.equipamentoMotorizado,
   'sinalizacaoVisual' : this.sinalizacaoVisual,
   'sinalizacaoTatil' : this.sinalizacaoTatil,
   'alarmeDeEmergencia' : this.alarmeDeEmergencia,
   'comunicacao' : this.comunicacao,
   'balcaoDeAtendimento' : this.balcaoDeAtendimento,
   'mobiliario' : this.mobiliario,
   'sanitario' : this.sanitario,
   'telefone' : this.telefone,
   'tabelEquipamentoEEspaco' : this.tabelEquipamentoEEspaco,
   'tabelaAreaOuEdificacao' : this.tabelaAreaOuEdificacao,
   'tabelaHorarios' : this.tabelaHorarios,
    };
  }

  ComercioTuristicoModel.fromJson(Map<String, dynamic> json) {
        id = json['id'];

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
    subtipo = List<String>.from(json['subtipo'] ?? []);
    natureza = json['natureza'];
    tipoDeOrganizacao = json['tipoDeOrganizacao'];
    localizacao = json['localizacao'];
    razaoSocial = json['razaoSocial'];
    nomeFantasia = json['nomeFantasia'];
    cNPJ = json['CNPJ'];
    codigoCNAE = json['codigoCNAE'];
    atividadeEconomica = json['atividadeEconomica'];
    inscricaoMunicipal = json['inscricaoMunicipal'];
    nomeDaRedeFranquia = json['nomeDaRedeFranquia'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    avenidaRuaTravessa = json['avenidaRuaTravessa'];
    bairroLocalidade = json['bairroLocalidade'];
    distrito = json['distrito'];
    cEP = json['CEP'];
    whatsapp = json['whatsapp'];
    instagram = json['instagram'];
    email = json['email'];
    site = json['site'];
    pontosDeReferencia = json['pontosDeReferencia'];
    outrasRegrasEInformacoes = json['outrasRegrasEInformacoes'];
    capacidadeDeVeiculos = json['capacidadeDeVeiculos'];
    automoveis = json['automoveis'];
    onibus = json['onibus'];
    outrasAcessibilidade = json['outrasAcessibilidade'];
    funcionamento24h = json['funcionamento24h'];
    funcionamentoEmFeriados = json['funcionamentoEmFeriados'];
    formasDePagamento = List<String>.from(json['formasDePagamento'] ?? []);
    atendimentoEmLinguaEstrangeira = json['atendimentoEmLinguaEstrangeira'];
    informativosImpressos = List<String>.from(json['informativosImpressos'] ?? []);
    regrasDeFuncionamentoPeriodo = List<String>.from(json['regrasDeFuncionamentoPeriodo'] ?? []);
    estacionamento = json['estacionamento'];
    produtosEServicos = List<String>.from(json['produtosEServicos'] ?? []);
    outrosServicos = List<String>.from(json['outrosServicos'] ?? []);
    doEquipamentoEspaco = json['doEquipamentoEspaco'];
    areaOuEdificacaoEmQueEstaInstalado =
        json['areaOuEdificacaoEmQueEstaInstalado'];
    possuiFacilidade = json['possuiFacilidade'];
    estadoGeralConservacao = json['estadoGeralConservacao'];
    sinalizacaoIndicativaPreferencial =
        json['sinalizacaoIndicativaPreferencial'];
    pessoalCapacitado = List<String>.from(json['pessoalCapacitado'] ?? []);
    rotaExternaAcessivel = List<String>.from(json['rotaExternaAcessivel'] ?? []);
    simboloInternacionalDeAcesso = List<String>.from(json['simboloInternacionalDeAcesso'] ?? []);
    localDeEmbarqueEDesembarque = List<String>.from(json['localDeEmbarqueEDesembarque'] ?? []);
    vagaEmEstacionamento = List<String>.from(json['vagaEmEstacionamento'] ?? []);
    areaDeCirculacao = List<String>.from(json['areaDeCirculacao'] ?? []);
    escada = List<String>.from(json['escada'] ?? []);
    rampa = List<String>.from(json['rampa'] ?? []);
    piso = List<String>.from(json['piso'] ?? []);
    elevador = List<String>.from(json['elevador'] ?? []);
    equipamentoMotorizado = List<String>.from(json['equipamentoMotorizado'] ?? []);
    sinalizacaoVisual = List<String>.from(json['sinalizacaoVisual'] ?? []);
    sinalizacaoTatil = List<String>.from(json['sinalizacaoTatil'] ?? []);
    alarmeDeEmergencia = List<String>.from(json['alarmeDeEmergencia'] ?? []);
    comunicacao = List<String>.from(json['comunicacao'] ?? []);
    balcaoDeAtendimento = List<String>.from(json['balcaoDeAtendimento'] ?? []);
    mobiliario = List<String>.from(json['mobiliario'] ?? []);
    sanitario = List<String>.from(json['sanitario'] ?? []);
    telefone = List<String>.from(json['telefone'] ?? []);
    tabelEquipamentoEEspaco = Map<String, dynamic>.from(json['tabelEquipamentoEEspaco'] ?? {});
    tabelaAreaOuEdificacao = Map<String, dynamic>.from(json['tabelaAreaOuEdificacao'] ?? {});
    tabelaHorarios = Map<String, dynamic>.from(json['tabelaHorarios'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sinalizacaoDeAcesso'] = this.sinalizacaoDeAcesso;
    data['sinalizacaoTuristica'] = this.sinalizacaoTuristica;
    data['subtipo'] = this.subtipo;
    data['natureza'] = this.natureza;
    data['tipoDeOrganizacao'] = this.tipoDeOrganizacao;
    data['localizacao'] = this.localizacao;
    data['razaoSocial'] = this.razaoSocial;
    data['nomeFantasia'] = this.nomeFantasia;
    data['CNPJ'] = this.cNPJ;
    data['codigoCNAE'] = this.codigoCNAE;
    data['atividadeEconomica'] = this.atividadeEconomica;
    data['inscricaoMunicipal'] = this.inscricaoMunicipal;
    data['nomeDaRedeFranquia'] = this.nomeDaRedeFranquia;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['avenidaRuaTravessa'] = this.avenidaRuaTravessa;
    data['bairroLocalidade'] = this.bairroLocalidade;
    data['distrito'] = this.distrito;
    data['CEP'] = this.cEP;
    data['whatsapp'] = this.whatsapp;
    data['instagram'] = this.instagram;
    data['email'] = this.email;
    data['site'] = this.site;
    data['pontosDeReferencia'] = this.pontosDeReferencia;
    data['outrasRegrasEInformacoes'] = this.outrasRegrasEInformacoes;
    data['capacidadeDeVeiculos'] = this.capacidadeDeVeiculos;
    data['automoveis'] = this.automoveis;
    data['onibus'] = this.onibus;
    data['outrasAcessibilidade'] = this.outrasAcessibilidade;
    data['funcionamento24h'] = this.funcionamento24h;
    data['funcionamentoEmFeriados'] = this.funcionamentoEmFeriados;
    data['formasDePagamento'] = this.formasDePagamento;
    data['atendimentoEmLinguaEstrangeira'] =
        this.atendimentoEmLinguaEstrangeira;
    data['informativosImpressos'] = this.informativosImpressos;
    data['regrasDeFuncionamentoPeriodo'] = this.regrasDeFuncionamentoPeriodo;
    data['estacionamento'] = this.estacionamento;
    data['produtosEServicos'] = this.produtosEServicos;
    data['outrosServicos'] = this.outrosServicos;
    data['doEquipamentoEspaco'] = this.doEquipamentoEspaco;
    data['areaOuEdificacaoEmQueEstaInstalado'] =
        this.areaOuEdificacaoEmQueEstaInstalado;
    data['possuiFacilidade'] = this.possuiFacilidade;
    data['estadoGeralConservacao'] = this.estadoGeralConservacao;
    data['sinalizacaoIndicativaPreferencial'] =
        this.sinalizacaoIndicativaPreferencial;
    data['pessoalCapacitado'] = this.pessoalCapacitado;
    data['rotaExternaAcessivel'] = this.rotaExternaAcessivel;
    data['simboloInternacionalDeAcesso'] = this.simboloInternacionalDeAcesso;
    data['localDeEmbarqueEDesembarque'] = this.localDeEmbarqueEDesembarque;
    data['vagaEmEstacionamento'] = this.vagaEmEstacionamento;
    data['areaDeCirculacao'] = this.areaDeCirculacao;
    data['escada'] = this.escada;
    data['rampa'] = this.rampa;
    data['piso'] = this.piso;
    data['elevador'] = this.elevador;
    data['equipamentoMotorizado'] = this.equipamentoMotorizado;
    data['sinalizacaoVisual'] = this.sinalizacaoVisual;
    data['sinalizacaoTatil'] = this.sinalizacaoTatil;
    data['alarmeDeEmergencia'] = this.alarmeDeEmergencia;
    data['comunicacao'] = this.comunicacao;
    data['balcaoDeAtendimento'] = this.balcaoDeAtendimento;
    data['mobiliario'] = this.mobiliario;
    data['sanitario'] = this.sanitario;
    data['telefone'] = this.telefone;
    data['tabelEquipamentoEEspaco'] = this.tabelEquipamentoEEspaco;
    data['tabelaAreaOuEdificacao'] = this.tabelaAreaOuEdificacao;
    data['tabelaHorarios'] = this.tabelaHorarios;
    return data;
  }
}

