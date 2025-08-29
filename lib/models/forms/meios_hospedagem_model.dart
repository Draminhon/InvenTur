class MeiosDeHospedagemModel{
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
  List<String>? segmentosOuTurismoEspecializado;
  List<String>? formasDePagamento;
  List<String>? reservas;
  List<String>? atendimentoEmLinguaEstrangeira;
  List<String>? informativosImpressos;
  List<String>? restricoes;
  List<String>? mesesAltaTemporada;
  List<String>? origemDosVisitantes;

  // Produtos e serviços
  List<String>? produtosHigienePessoal;
  List<String>? equipamentosEServicos;
  List<String>? estacionamento;
  List<String>? restaurante;
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
  String? tipoDeDiaria;
  List<String>? periodo;
  Map<String, dynamic>? tabelasHorario;
  String? energiaEletrica;
  String? estadoGeralDeConservacao;

  // Dados de turismo e localização geográfica
  List<String>? estadosTuristas;
  List<String>? paisesTuristas;

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
  int? qtdeFuncionariosPermanentes;
  int? qtdeFuncionariosTemporarios;
  int? qtdeFuncionarisComDeficiencia;
  String? latitude;
  String? longitute;

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
  String? nOcupacaoAltaTemporada;
  int? nTotalDeUH;
  int? nTotalDeLeitos;
  int? nUhAdaptadasParaPCD;
  int? nCapacidadeDeVeiculos;
  int? nAutomoveis;
  int? nOnibus;
  String? capacidadeEmKVA;
  String? geradorCapacidadeEmKVA;
  int? nCapacidadeInstaladaPorDia;
  int? nPessoasAtendidasSentadas;
  int? nCapacidadeSimultanea;
  int? nPessoasAtendidasSentadasSimultanea;
  int? lanchoneteCapacidadeInstaladaPorDia;
  int? lanchoneteCapacidadePessoasAtendidasSentadas;
  int? lanchoneteCapacidadeSimultanea;
  int? lanchoneteCapacidadeSentadasSimultanea;
  Map<String, dynamic>? tabelaInstalacoes;
  Map<String, dynamic>? tabelaEquipamentoEEspaco;
  Map<String, dynamic>? tabelaEquipamentoEEspaco2;
  String? outros;
    List<String>? origemNacional;
  List<String>? origemInternacional;

  MeiosDeHospedagemModel({
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
    this.funcionamento24h,
    this.funcionamentoEmFeriados,
    this.geradorDeEmergencia,
    this.doEquipamentoEspaco,
    this.daAreaOuEdificacaoEmQueEstaLocalizado,
    this.possuiFacilidade,
    this.sinalizacaoIndicativa,
    this.tipoDeOrganizacao,
    this.proximidades,
    this.segmentosOuTurismoEspecializado,
    this.formasDePagamento,
    this.reservas,
    this.atendimentoEmLinguaEstrangeira,
    this.informativosImpressos,
    this.restricoes,
    this.mesesAltaTemporada,
    this.origemDosVisitantes,
    this.produtosHigienePessoal,
    this.equipamentosEServicos,
    this.estacionamento,
    this.restaurante,
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
    this.tipoDeDiaria,
    this.periodo,
    this.tabelasHorario,
    this.energiaEletrica,
    this.estadoGeralDeConservacao,
    this.estadosTuristas,
    this.paisesTuristas,
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
    this.longitute,
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
    this.nOcupacaoAltaTemporada,
    this.nTotalDeUH,
    this.nTotalDeLeitos,
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
          this.origemNacional,
      this.origemInternacional,
  });

  MeiosDeHospedagemModel.fromJson(Map<String, dynamic> json) {
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
  funcionamento24h = json['funcionamento24h'];
  funcionamentoEmFeriados = json['funcionamentoEmFeriados'];
  geradorDeEmergencia = json['geradorDeEmergencia'];
  doEquipamentoEspaco = json['doEquipamentoEspaco'];
  daAreaOuEdificacaoEmQueEstaLocalizado =
      json['daAreaOuEdificacaoEmQueEstaLocalizado'];
  possuiFacilidade = json['possuiFacilidade'];
  sinalizacaoIndicativa = json['sinalizacaoIndicativa'];
  tipoDeOrganizacao = json['tipoDeOrganizacao'] != null
      ? List<String>.from(json['tipoDeOrganizacao'])
      : null;
  proximidades = json['proximidades'] != null
      ? List<String>.from(json['proximidades'])
      : null;
  segmentosOuTurismoEspecializado =
      List<String>.from(json['segmentosOuTurismoEspecializado']);
  formasDePagamento =
      List<String>.from(json['formasDePagamento']);
  reservas = List<String>.from(json['reservas']);
  atendimentoEmLinguaEstrangeira =
      List<String>.from(json['atendimentoEmLinguaEstrangeira']);
  informativosImpressos =
      List<String>.from(json['informativosImpressos']);
  restricoes = List<String>.from(json['restricoes']);
  mesesAltaTemporada =
      List<String>.from(json['mesesAltaTemporada']);
  origemDosVisitantes =
      List<String>.from(json['origemDosVisitantes']);
  produtosHigienePessoal =
      List<String>.from(json['produtosHigienePessoal']);
  equipamentosEServicos =
      List<String>.from(json['equipamentosEServicos']);
  estacionamento = List<String>.from(json['estacionamento']);
  restaurante = List<String>.from(json['restaurante']);
  lanchonete = List<String>.from(json['lanchonete']);
  instalacaoEEspacos =
      List<String>.from(json['instalacaoEEspacos']);
  outrosEspacosEAtividades =
      List<String>.from(json['outrosEspacosEAtividades']);
  servicos = List<String>.from(json['servicos']);
  equipamentos = List<String>.from(json['equipamentos']);
  facilidadesEServicos =
      List<String>.from(json['facilidadesEServicos']);
  facilidadesParaExecutivos =
      List<String>.from(json['facilidadesParaExecutivos']);
  pessoalCapacitadoParaReceberPCD =
      List<String>.from(json['pessoalCapacitadoParaReceberPCD']);
  rotaExternaAcessivel =
      List<String>.from(json['rotaExternaAcessivel']);
  simboloInternacionalDeAcesso =
      List<String>.from(json['simboloInternacionalDeAcesso']);
  localDeEmbarqueEDesembarque =
      List<String>.from(json['localDeEmbarqueEDesembarque']);
  vagaEmEstacionamento =
      List<String>.from(json['vagaEmEstacionamento']);
  areaDeCirculacaoAcessoInterno =
      List<String>.from(json['areaDeCirculacaoAcessoInterno']);
  escada = List<String>.from(json['escada']);
  rampa = List<String>.from(json['rampa']);
  piso = List<String>.from(json['piso']);
  elevador = List<String>.from(json['elevador']);
  equipamentoMotorizadoParaDeslocamentoInterno =
      List<String>.from(json['equipamentoMotorizadoParaDeslocamentoInterno']);
  sinalizacaoVisual =
      List<String>.from(json['sinalizacaoVisual']);
  sinalizacaoTatil =
      List<String>.from(json['sinalizacaoTatil']);
  alarmeDeEmergencia =
      List<String>.from(json['alarmeDeEmergencia']);
  comunicacao = List<String>.from(json['comunicacao']);
  balcaoDeAtendimento =
      List<String>.from(json['balcaoDeAtendimento']);
  mobiliario = List<String>.from(json['mobiliario']);
  sanitario = List<String>.from(json['sanitario']);
  telefone = List<String>.from(json['telefone']);
  subtipo = List<String>.from(json['subtipo']);
  natureza = json['natureza'];
  localizacao = json['localizacao'];
  tipoDeDiaria = json['tipoDeDiaria'];
  periodo = List<String>.from(json['periodo']);
  tabelasHorario = Map<String, dynamic>.from(json['tabelasHorario'] ?? {});
  energiaEletrica = json['energiaEletrica'];
  estadoGeralDeConservacao = json['estadoGeralDeConservacao'];
  estadosTuristas = List<String>.from(json['estadosTuristas']);
  paisesTuristas = List<String>.from(json['paisesTuristas']);
  razaoSocial = json['razaoSocial'];
  nomeFantasia = json['nomeFantasia'];
  codigoCNAE = json['codigoCNAE'];
  atividadeEconomica = json['atividadeEconomica'];
  inscricaoMunicipal = json['inscricaoMunicipal'];
  nomeDaRede = json['nomeDaRede'];
  CNPJ = json['CNPJ'];
  inicioDaAtividade = json['inicioDaAtividade'];
  qtdeFuncionariosPermanentes =
      json['qtdeFuncionariosPermanentes'];
  qtdeFuncionariosTemporarios =
      json['qtdeFuncionariosTemporarios'];
  qtdeFuncionarisComDeficiencia =
      json['qtdeFuncionarisComDeficiencia'];
  latitude = json['latitude'];
  longitute = json['longitute'];
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
  nOcupacaoAltaTemporada = json['nOcupacaoAltaTemporada'];
  nTotalDeUH = json['nTotalDeUH'];
  nTotalDeLeitos = json['nTotalDeLeitos'];
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
  lanchoneteCapacidadeSimultanea =
      json['lanchoneteCapacidadeSimultanea'];
  lanchoneteCapacidadeSentadasSimultanea =
      json['lanchoneteCapacidadeSentadasSimultanea'];
  tabelaInstalacoes =
      Map<String, dynamic>.from(json['tabelaInstalacoes'] ?? {});
  tabelaEquipamentoEEspaco =
      Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco'] ?? {});
  tabelaEquipamentoEEspaco2 =
      Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco2']  ?? {});
  outros = json['outros'];
   origemNacional =  List<String>.from(json['origemNacional']);
    origemInternacional =  List<String>.from(json['origemInternacional']);
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo_formulario'] = tipoFormulario;
    data['uf'] = uf;
    data['regiao_turistica'] = regiaoTuristica;
    data['municipio'] = municipio;
    data['tipo'] = tipo;
    data['observacoes'] = observacoes;
    data['referencias'] = referencias;
    data['nome_pesquisador'] = nomePesquisador;
    data['telefone_pesquisador'] = telefonePesquisador;
    data['email_pesquisador'] = emailPesquisador;
    data['nome_coordenador'] = nomeCoordenador;
    data['telefone_coordenador'] = telefoneCoordenador;
    data['email_coordenador'] = emailCoordenador;
    data['sinalizacao_de_acesso'] = sinalizacaoDeAcesso;
    data['sinalizacao_turistica'] = sinalizacaoTuristica;
    data['funcionamento_24h'] = funcionamento24h;
    data['funcionamento_em_feriados'] = funcionamentoEmFeriados;
    data['gerador_de_emergencia'] = geradorDeEmergencia;
    data['do_equipamento_espaco'] = doEquipamentoEspaco;
    data['da_area_ou_edificacao_em_que_esta_localizado'] =
        daAreaOuEdificacaoEmQueEstaLocalizado;
    data['possui_facilidade'] = possuiFacilidade;
    data['sinalizacao_indicativa'] = sinalizacaoIndicativa;
    data['tipo_de_organizacao'] = tipoDeOrganizacao;
    data['proximidades'] = proximidades;
    data['segmentos_ou_turismo_especializado'] =
        segmentosOuTurismoEspecializado;
    data['formas_de_pagamento'] = formasDePagamento;
    data['reservas'] = reservas;
    data['atendimento_em_lingua_estrangeira'] =
        atendimentoEmLinguaEstrangeira;
    data['informativos_impressos'] = informativosImpressos;
    data['restricoes'] = restricoes;
    data['meses_alta_temporada'] = mesesAltaTemporada;
    data['origem_dos_visitantes'] = origemDosVisitantes;
    data['produtos_higiene_pessoal'] = produtosHigienePessoal;
    data['equipamentos_e_servicos'] = equipamentosEServicos;
    data['estacionamento'] = estacionamento;
    data['restaurante'] = restaurante;
    data['lanchonete'] = lanchonete;
    data['instalacao_e_espacos'] = instalacaoEEspacos;
    data['outros_espacos_e_atividades'] = outrosEspacosEAtividades;
    data['servicos'] = servicos;
    data['equipamentos'] = equipamentos;
    data['facilidades_e_servicos'] = facilidadesEServicos;
    data['facilidades_para_executivos'] = facilidadesParaExecutivos;
    data['pessoal_capacitado_para_receber_pcd'] =
        pessoalCapacitadoParaReceberPCD;
    data['rota_externa_acessivel'] = rotaExternaAcessivel;
    data['simbolo_internacional_de_acesso'] = simboloInternacionalDeAcesso;
    data['local_de_embarque_e_desembarque'] = localDeEmbarqueEDesembarque;
    data['vaga_em_estacionamento'] = vagaEmEstacionamento;
    data['area_de_circulacao_acesso_interno'] = areaDeCirculacaoAcessoInterno;
    data['escada'] = escada;
    data['rampa'] = rampa;
    data['piso'] = piso;
    data['elevador'] = elevador;
    data['equipamento_motorizado_para_deslocamento_interno'] =
        equipamentoMotorizadoParaDeslocamentoInterno;
    data['sinalizacao_visual'] = sinalizacaoVisual;
    data['sinalizacao_tatil'] = sinalizacaoTatil;
    data['alarme_de_emergencia'] = alarmeDeEmergencia;
    data['comunicacao'] = comunicacao;
    data['balcao_de_atendimento'] = balcaoDeAtendimento;
    data['mobiliario'] = mobiliario;
    data['sanitario'] = sanitario;
    data['telefone'] = telefone;
    data['subtipo'] = subtipo;
    data['natureza'] = natureza;
    data['localizacao'] = localizacao;
    data['tipo_de_diaria'] = tipoDeDiaria;
    data['periodo'] = periodo;
    data['tabelas_horario'] = tabelasHorario;
    data['energia_eletrica'] = energiaEletrica;
    data['estado_geral_de_conservacao'] = estadoGeralDeConservacao;
    data['estados_turistas'] = estadosTuristas;
    data['paises_turistas'] = paisesTuristas;
    data['razao_social'] = razaoSocial;
    data['nome_fantasia'] = nomeFantasia;
    data['codigo_cnae'] = codigoCNAE;
    data['atividade_economica'] = atividadeEconomica;
    data['inscricao_municipal'] = inscricaoMunicipal;
    data['nome_da_rede'] = nomeDaRede;
    data['cnpj'] = CNPJ;
    data['inicio_da_atividade'] = inicioDaAtividade;
    data['qtde_funcionarios_permanentes'] = qtdeFuncionariosPermanentes;
    data['qtde_funcionarios_temporarios'] = qtdeFuncionariosTemporarios;
    data['qtde_funcionarios_com_deficiencia'] = qtdeFuncionarisComDeficiencia;
    data['latitude'] = latitude;
    data['longitute'] = longitute;
    data['avenida_rua_etc'] = avenidaRuaEtc;
    data['bairro_localidade'] = bairroLocalidade;
    data['distrito'] = distrito;
    data['cep'] = CEP;
    data['whatsapp'] = whatsapp;
    data['instagram'] = instagram;
    data['email'] = email;
    data['site'] = site;
    data['pontos_de_referencia'] = pontosDeReferencia;
    data['tabela_mtur'] = tabelaMTUR;
    data['outras_regras_e_informacoes'] = outrasRegrasEInformacoes;
    data['n_ano_ocupacao'] = nAnoOcupacao;
    data['n_ocupacao_alta_temporada'] = nOcupacaoAltaTemporada;
    data['n_total_de_uh'] = nTotalDeUH;
    data['n_total_de_leitos'] = nTotalDeLeitos;
    data['n_uh_adaptadas_para_pcd'] = nUhAdaptadasParaPCD;
    data['n_capacidade_de_veiculos'] = nCapacidadeDeVeiculos;
    data['n_automoveis'] = nAutomoveis;
    data['n_onibus'] = nOnibus;
    data['capacidade_em_kva'] = capacidadeEmKVA;
    data['gerador_capacidade_em_kva'] = geradorCapacidadeEmKVA;
    data['n_capacidade_instalada_por_dia'] = nCapacidadeInstaladaPorDia;
    data['n_pessoas_atendidas_sentadas'] = nPessoasAtendidasSentadas;
    data['n_capacidade_simultanea'] = nCapacidadeSimultanea;
    data['n_pessoas_atendidas_sentadas_simultanea'] =
        nPessoasAtendidasSentadasSimultanea;
    data['lanchonete_capacidade_instalada_por_dia'] =
        lanchoneteCapacidadeInstaladaPorDia;
    data['lanchonete_capacidade_pessoas_atendidas_sentadas'] =
        lanchoneteCapacidadePessoasAtendidasSentadas;
    data['lanchonete_capacidade_simultanea'] = lanchoneteCapacidadeSimultanea;
    data['lanchonete_capacidade_sentadas_simultanea'] =
        lanchoneteCapacidadeSentadasSimultanea;
    data['tabela_instalacoes'] = tabelaInstalacoes;
    data['tabela_equipamento_e_espaco'] = tabelaEquipamentoEEspaco;
    data['tabela_equipamento_e_espaco_2'] = tabelaEquipamentoEEspaco2;
    data['outros'] = outros;
        data['origemNacional'] = this.origemNacional;
    data['origemInternacional'] = this.origemInternacional;
    return data;
  }
}
