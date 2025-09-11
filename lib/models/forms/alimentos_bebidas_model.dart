class AlimentosEBebidasModel {
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
  String? outrasRegraseInformacoes;
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
  Map<String, dynamic>? tabelaEquipamentoEEspaco;
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
    this.formasDePagamento,
    this.vendasEReservas,
    this.atendimentoEmLinguasEstrangeiras,
    this.informativosImpressos,
    this.periodo,
    this.tabelasHorario,
    this.funcionamento24h,
    this.funcionamentoEmFeriados,
    this.restricoes,
    this.outrasRegraseInformacoes,
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
  tipoDeOrganizacaoInstituicao = List<String>.from(json['tipoDeOrganizacaoInstituicao']);
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
  proximidades = List<String>.from(json['proximidades']);
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
  tabelaMTUR = Map<String, dynamic>.from(json['tabelaMTUR']);
  formasDePagamento = List<String>.from(json['formasDePagamento']);
  vendasEReservas = List<String>.from(json['vendasEReservas']);
  atendimentoEmLinguasEstrangeiras = List<String>.from(json['atendimentoEmLinguasEstrangeiras']);
  informativosImpressos = List<String>.from(json['informativosImpressos']);
  periodo = List<String>.from(json['periodo']);
  tabelasHorario = Map<String, dynamic>.from(json['tabelasHorario'] ?? {});
  funcionamento24h = json['funcionamento24h'];
  funcionamentoEmFeriados = json['funcionamentoEmFeriados'];
  restricoes = List<String>.from(json['restricoes']);
  outrasRegraseInformacoes = json['outrasRegraseInformacoes'];
  capInstaladaPdia = json['capInstaladaPdia'];
  capInstaladasSentadas = json['capInstaladasSentadas'];
  capSimultanea = json['capSimultanea'];
  capSimultaneaSentadas = json['capSimultaneaSentadas'];
  estacionamento = List<String>.from(json['estacionamento']);
  capacidadeVeiculos = json['capacidadeVeiculos'];
  numeroAutomoveis = json['numeroAutomoveis'];
  numeroOnibus = json['numeroOnibus'];
  servicosEEquipamentos = List<String>.from(json['servicosEEquipamentos']);
  especificacaoDaGastronomiaPorPais = List<String>.from(json['especificacaoDaGastronomiaPorPais']);
  seForBrasileiraPorRegiao = List<String>.from(json['seForBrasileiraPorRegiao']);
  porEspecializacao = List<String>.from(json['porEspecializacao']);
  porTipoDeDieta = List<String>.from(json['porTipoDeDieta']);
  porTipoDeServico = List<String>.from(json['porTipoDeServico']);
  doEquipamento = json['doEquipamento'];
  tabelaEquipamentoEEspaco = Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco']);
  estadoGeralDeConservacao = json['estadoGeralDeConservacao'];
  possuiFacilidade = json['possuiFacilidade'];
  pessoalCapacitadoParaReceberPCD = List<String>.from(json['pessoalCapacitadoParaReceberPCD']);
  rotaExternaAcessivel = List<String>.from(json['rotaExternaAcessível']);
  simboloInternacionalDeAcesso = List<String>.from(json['simboloInternacionalDeAcesso']);
  localDeEmbarqueEDesembarque = List<String>.from(json['localDeEmbarqueEDesembarque']);
  vagaEmEstacionamento = List<String>.from(json['vagaEmEstacionamento']);
  areaDeCirculacaoAcessoInternoParaCadeiraDeRodas = List<String>.from(json['areaDeCirculacaoAcessoInternoParaCadeiraDeRodas']);
  escada = List<String>.from(json['escada']);
  rampa = List<String>.from(json['rampa']);
  piso = List<String>.from(json['piso']);
  elevador = List<String>.from(json['elevador']);
  equipamentoMotorizadoParaDeslocamentoInterno = List<String>.from(json['equipamentoMotorizadoParaDeslocamentoInterno']);
  sinalizacaoVisual = List<String>.from(json['sinalizacaoVisual']);
  sinalizacaoTatil = List<String>.from(json['sinalizacaoTatil']);
  alarmeDeEmergencia = List<String>.from(json['alarmeDeEmergencia']);
  comunicacao = List<String>.from(json['comunicacao']);
  balcaoDeAtendimento = List<String>.from(json['balcaoDeAtendimento']);
  mobiliario = List<String>.from(json['mobiliario']);
  sanitario = List<String>.from(json['sanitario']);
  telefone = List<String>.from(json['telefone']);
  sinalizacaoIndicativa = json['sinalizacaoIndicativa'];
  outrosAcessibilidade = json['outrosAcessibilidade'];
}

Map<String, dynamic> toMap() {
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
    data['razaoSocial'] = razaoSocial;
    data['nomeFantasia'] = nomeFantasia;
    data['cnpj'] = CNPJ;
    data['codigo_cnae'] = codigoCNAE;
    data['atividade_economica'] = atividadeEconomica;
    data['inscricao_municipal'] = inscricaoMunicipal;
    data['nome_da_rede'] = nomeDaRede;
    data['natureza'] = natureza;
    data['tipo_de_organizacao_instituicao'] = tipoDeOrganizacaoInstituicao;
    data['inicio_da_atividade'] = inicioDaAtividade;
    data['qtde_funcionarios_permanentes'] = qtdeFuncionariosPermanentes;
    data['qtde_funcionarios_temporarios'] = qtdeFuncionariosTemporarios;
    data['qtde_funcionarios_com_deficiencia'] = qtdeFuncionariosComDeficiencia;
    data['localizacao'] = localizacao;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['avenida_rua_etc'] = avenidaRuaEtc;
    data['bairro_localidade'] = bairroLocalidade;
    data['distrito'] = distrito;
    data['cep'] = CEP;
    data['whatsapp'] = whatsapp;
    data['instagram'] = instagram;
    data['email'] = email;
    data['sinalizacao_de_acesso'] = sinalizacaoDeAcesso;
    data['sinalizacao_turistica'] = sinalizacaoTuristica;
    data['proximidades'] = proximidades;
    data['distancias_aeroporto'] = distanciasAeroporto;
    data['distancias_rodoviaria'] = distanciasRodoviaria;
    data['distancia_estacao_ferroviaria'] = distanciaEstacaoFerroviaria;
    data['distancia_estacao_maritima'] = distanciaEstacaoMaritima;
    data['distancia_estacao_metroviaria'] = distanciaEstacaoMetroviaria;
    data['distancia_ponto_de_onibus'] = distanciaPontoDeOnibus;
    data['distancia_ponto_de_taxi'] = distanciaPontoDeTaxi;
    data['distancias_outra_nome'] = distanciasOutraNome;
    data['distancia_outras'] = distanciaOutras;
    data['pontos_de_referencia'] = pontosDeReferencia;
    data['tabela_mtur'] = tabelaMTUR;
    data['formas_de_pagamento'] = formasDePagamento;
    data['vendas_e_reservas'] = vendasEReservas;
    data['atendimento_em_linguas_estrangeiras'] = atendimentoEmLinguasEstrangeiras;
    data['informativos_impressos'] = informativosImpressos;
    data['periodo'] = periodo;
    data['tabelas_horario'] = tabelasHorario;
    data['funcionamento_24h'] = funcionamento24h;
    data['funcionamento_em_feriados'] = funcionamentoEmFeriados;
    data['restricoes'] = restricoes;
    data['outras_regras_e_informacoes'] = outrasRegraseInformacoes;
    data['cap_instalada_pdia'] = capInstaladaPdia;
    data['cap_instaladas_sentadas'] = capInstaladasSentadas;
    data['cap_simultanea'] = capSimultanea;
    data['cap_simultanea_sentadas'] = capSimultaneaSentadas;
    data['estacionamento'] = estacionamento;
    data['capacidade_veiculos'] = capacidadeVeiculos;
    data['numero_automoveis'] = numeroAutomoveis;
    data['numero_onibus'] = numeroOnibus;
    data['servicos_e_equipamentos'] = servicosEEquipamentos;
    data['especificacao_da_gastronomia_por_pais'] = especificacaoDaGastronomiaPorPais;
    data['se_for_brasileira_por_regiao'] = seForBrasileiraPorRegiao;
    data['por_especializacao'] = porEspecializacao;
    data['por_tipo_de_dieta'] = porTipoDeDieta;
    data['por_tipo_de_servico'] = porTipoDeServico;
    data['do_equipamento'] = doEquipamento;
    data['tabela_equipamento_e_espaco'] = tabelaEquipamentoEEspaco;
    data['estado_geral_de_conservacao'] = estadoGeralDeConservacao;
    data['possui_facilidade'] = possuiFacilidade;
    data['pessoal_capacitado_para_receber_pcd'] = pessoalCapacitadoParaReceberPCD;
    data['rota_externa_acessivel'] = rotaExternaAcessivel;
    data['simbolo_internacional_de_acesso'] = simboloInternacionalDeAcesso;
    data['local_de_embarque_e_desembarque'] = localDeEmbarqueEDesembarque;
    data['vaga_em_estacionamento'] = vagaEmEstacionamento;
    data['area_de_circulacao_acesso_interno_para_cadeira_de_rodas'] = areaDeCirculacaoAcessoInternoParaCadeiraDeRodas;
    data['escada'] = escada;
    data['rampa'] = rampa;
    data['piso'] = piso;
    data['elevador'] = elevador;
    data['equipamento_motorizado_para_deslocamento_interno'] = equipamentoMotorizadoParaDeslocamentoInterno;
    data['sinalizacao_visual'] = sinalizacaoVisual;
    data['sinalizacao_tatil'] = sinalizacaoTatil;
    data['alarme_de_emergencia'] = alarmeDeEmergencia;
    data['comunicacao'] = comunicacao;
    data['balcao_de_atendimento'] = balcaoDeAtendimento;
    data['mobiliario'] = mobiliario;
    data['sanitario'] = sanitario;
    data['telefone'] = telefone;
    data['sinalizacao_indicativa'] = sinalizacaoIndicativa;
    data['outros_acessibilidade'] = outrosAcessibilidade;
    return data;
  }
}