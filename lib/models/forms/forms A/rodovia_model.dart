class RodoviaModel{
    late List<RodoviaModel> _rodovias;
    List<RodoviaModel> get rodovias => _rodovias;
  int? id;
  
  int? usuario_criador;
  String? tipoFormulario;
  String? criacao;
  String? atualizacao;
  String? uf;
  String? regiaoTuristica;
  String? municipio;
  String? tipo;
  String? subtipos;
  String? nomeOficial;
  String? nomePopular;
  String? jurisdicao;
  String? natureza;
  List<String>? tipoDeOrganizacaoInstituicao;
  String? extensaoRodoviaMunicipio;
  String? faixasDeRolamento;
  String? pavimentacao;
  String? pedagio;
  String? municipiosVizinhosInterligadosRodovia;
  String? inicioAtividade;
  String? whatsapp;
  String? instagram;
  String? sinalizacaoDeAcesso;
  String? sinalizacaoTuristica;
  List<String>? postoDeCombustivel;
  List<String>? outrosServicos;
  List<String>? estruturasAoLongoDaVia;
  String? poluicao;
  String? poluicaoEspecificacao;
  String? lixo;
  String? lixoEspecificacao;
  String? desmatamento;
  String? desmatamentoEspecificacao;
  String? queimadas;
  String? queimadasEspecificacao;
  String? inseguranca;
  String? insegurancaEspecificacao;
  String? extrativismo;
  String? extrativismoEspecificacao;
  String? prostituicao;
  String? prostituicaoEspecificacao;
  String? ocupacaoIrregularInvasao;
  String? ocupacaoIrregularInvasaoEspecificacao;
  String? outras;
  String? outrasEspecificacao;
  String? estadoGeralDeConservacao;
  String? observacoes;
  String? referencias;
  String? nomePesquisador;
  String? telefonePesquisador;
  String? emailPesquisador;
  String? nomeCoordenador;
  String? telefoneCoordenador;
  String? emailCoordenador;

  RodoviaModel(
      {  
      this.id,
      this.usuario_criador,
      this.tipoFormulario,
      this.criacao,
      this.atualizacao,
      this.uf,
      this.regiaoTuristica,
      this.municipio,
      this.tipo,
      this.subtipos,
      this.nomeOficial,
      this.nomePopular,
      this.jurisdicao,
      this.natureza,
      this.tipoDeOrganizacaoInstituicao,
      this.extensaoRodoviaMunicipio,
      this.faixasDeRolamento,
      this.pavimentacao,
      this.pedagio,
      this.municipiosVizinhosInterligadosRodovia,
      this.inicioAtividade,
      this.whatsapp,
      this.instagram,
      this.sinalizacaoDeAcesso,
      this.sinalizacaoTuristica,
      this.postoDeCombustivel,
      this.outrosServicos,
      this.estruturasAoLongoDaVia,
      this.poluicao,
      this.poluicaoEspecificacao,
      this.lixo,
      this.lixoEspecificacao,
      this.desmatamento,
      this.desmatamentoEspecificacao,
      this.queimadas,
      this.queimadasEspecificacao,
      this.inseguranca,
      this.insegurancaEspecificacao,
      this.extrativismo,
      this.extrativismoEspecificacao,
      this.prostituicao,
      this.prostituicaoEspecificacao,
      this.ocupacaoIrregularInvasao,
      this.ocupacaoIrregularInvasaoEspecificacao,
      this.outras,
      this.outrasEspecificacao,
      this.estadoGeralDeConservacao,
      this.observacoes,
      this.referencias,
      this.nomePesquisador,
      this.telefonePesquisador,
      this.emailPesquisador,
      this.nomeCoordenador,
      this.telefoneCoordenador,
      this.emailCoordenador
      
      
      }){
       // _rodovias = rodovias;
      }

  RodoviaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario_criador = json['usuario_criador'];
    tipoFormulario = json['tipo_formulario'];
    criacao = json['criacao'];
    atualizacao = json['atualizacao'];
    uf = json['uf'];
    regiaoTuristica = json['regiao_turistica'];
    municipio = json['municipio'];
    tipo = json['tipo'];
    subtipos = json['subtipos'];
    nomeOficial = json['nome_oficial'];
    nomePopular = json['nome_popular'];
    jurisdicao = json['jurisdicao'];
    natureza = json['natureza'];
    tipoDeOrganizacaoInstituicao = List<String>.from(json['tipo_de_organizacao_instituicao'] ?? []);
    extensaoRodoviaMunicipio = json['extensao_rodovia_municipio'];
    faixasDeRolamento = json['faixas_de_rolamento'];
    pavimentacao = json['pavimentacao'];
    pedagio = json['pedagio'];
    municipiosVizinhosInterligadosRodovia =
        json['municipios_vizinhos_interligados_rodovia'];
    inicioAtividade = json['inicio_atividade'];
    whatsapp = json['whatsapp'];
    instagram = json['instagram'];
    sinalizacaoDeAcesso = json['sinalizacao_de_acesso'];
    sinalizacaoTuristica = json['sinalizacao_turistica'];
    postoDeCombustivel = List<String>.from(json['posto_de_combustivel']?? []);
    outrosServicos = List<String>.from(json['outros_servicos']?? []);
    estruturasAoLongoDaVia = List<String>.from(json['estruturas_ao_longo_da_via']?? []);
    poluicao = json['poluicao'];
    poluicaoEspecificacao = json['poluicao_especificacao'];
    lixo = json['lixo'];
    lixoEspecificacao = json['lixo_especificacao'];
    desmatamento = json['desmatamento'];
    desmatamentoEspecificacao = json['desmatamento_especificacao'];
    queimadas = json['queimadas'];
    queimadasEspecificacao = json['queimadas_especificacao'];
    inseguranca = json['inseguranca'];
    insegurancaEspecificacao = json['inseguranca_especificacao'];
    extrativismo = json['extrativismo'];
    extrativismoEspecificacao = json['extrativismo_especificacao'];
    prostituicao = json['prostituicao'];
    prostituicaoEspecificacao = json['prostituicao_especificacao'];
    ocupacaoIrregularInvasao = json['ocupacao_irregular_invasao'];
    ocupacaoIrregularInvasaoEspecificacao =
        json['ocupacao_irregular_invasao_especificacao'];
    outras = json['outras'];
    outrasEspecificacao = json['outras_especificacao'];
    estadoGeralDeConservacao = json['estado_geral_de_conservacao'];
    observacoes = json['observacoes'];
    referencias = json['referencias'];
    nomePesquisador = json['nome_pesquisador'];
    telefonePesquisador = json['telefone_pesquisador'];
    emailPesquisador = json['email_pesquisador'];
    nomeCoordenador = json['nome_coordenador'];
    telefoneCoordenador = json['telefone_coordenador'];
    emailCoordenador = json['email_coordenador'];
    // if(json['rodovias' != null]){
    //     _rodovias = <Rodovia>[];
    //     json['rodovias'].forEach((v){
    //         _rodovias.add(Rodovia.fromJson(v));
    //     });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['usuario_criador'] = usuario_criador;
    data['criacao'] = criacao;
    data['atualizacao'] = atualizacao;
    data['uf'] = uf;
    data['regiao_turistica'] = regiaoTuristica;
    data['municipio'] = municipio;
    data['tipo'] = tipo;
    data['subtipos'] = subtipos;
    data['nome_oficial'] = nomeOficial;
    data['nome_popular'] = nomePopular;
    data['jurisdicao'] = jurisdicao;
    data['natureza'] = natureza;
    data['tipo_de_organizacao_instituicao'] = tipoDeOrganizacaoInstituicao;
    data['extensao_rodovia_municipio'] = extensaoRodoviaMunicipio;
    data['faixas_de_rolamento'] = faixasDeRolamento;
    data['pavimentacao'] = pavimentacao;
    data['pedagio'] = pedagio;
    data['municipios_vizinhos_interligados_rodovia'] =
        municipiosVizinhosInterligadosRodovia;
    data['inicio_atividade'] = inicioAtividade;
    data['whatsapp'] = whatsapp;
    data['instagram'] = instagram;
    data['sinalizacao_de_acesso'] = sinalizacaoDeAcesso;
    data['sinalizacao_turistica'] = sinalizacaoTuristica;
    data['posto_de_combustivel'] = postoDeCombustivel;
    data['outros_servicos'] = outrosServicos;
    data['estruturas_ao_longo_da_via'] = estruturasAoLongoDaVia;
    data['poluicao'] = poluicao;
    data['poluicao_especificacao'] = poluicaoEspecificacao;
    data['lixo'] = lixo;
    data['lixo_especificacao'] = lixoEspecificacao;
    data['desmatamento'] = desmatamento;
    data['desmatamento_especificacao'] = desmatamentoEspecificacao;
    data['queimadas'] = queimadas;
    data['queimadas_especificacao'] = queimadasEspecificacao;
    data['inseguranca'] = inseguranca;
    data['inseguranca_especificacao'] = insegurancaEspecificacao;
    data['extrativismo'] = extrativismo;
    data['extrativismo_especificacao'] = extrativismoEspecificacao;
    data['prostituicao'] = prostituicao;
    data['prostituicao_especificacao'] = prostituicaoEspecificacao;
    data['ocupacao_irregular_invasao'] = ocupacaoIrregularInvasao;
    data['ocupacao_irregular_invasao_especificacao'] =
        ocupacaoIrregularInvasaoEspecificacao;
    data['outras'] = outras;
    data['outras_especificacao'] = outrasEspecificacao;
    data['estado_geral_de_conservacao'] = estadoGeralDeConservacao;
    data['observacoes'] = observacoes;
    data['referencias'] = referencias;
    data['nome_pesquisador'] = nomePesquisador;
    data['telefone_pesquisador'] = telefonePesquisador;
    data['email_pesquisador'] = emailPesquisador;
    data['nome_coordenador'] = nomeCoordenador;
    data['telefone_coordenador'] = telefoneCoordenador;
    data['email_coordenador'] = emailCoordenador;
    return data;
  }

   Map<String, dynamic> toMap() {
    return {
    'id': id,
    'usuario_criador': usuario_criador,
    'criacao': criacao,
    'atualizacao': atualizacao,
    'uf': uf,
    'regiao_turistica': regiaoTuristica,
    'municipio': municipio,
    'tipo': tipo,
    'subtipos': subtipos,
    'nome_oficial': nomeOficial,
    'nome_popular': nomePopular,
    'jurisdicao': jurisdicao,
    'natureza': natureza,
    'tipo_de_organizacao_instituicao': tipoDeOrganizacaoInstituicao,
    'extensao_rodovia_municipio': extensaoRodoviaMunicipio,
    'faixas_de_rolamento': faixasDeRolamento,
    'pavimentacao': pavimentacao,
    'pedagio': pedagio,
    'municipios_vizinhos_interligados_rodovia':
        municipiosVizinhosInterligadosRodovia,
    'inicio_atividade': inicioAtividade,
    'whatsapp': whatsapp,
    'instagram': instagram,
    'sinalizacao_de_acesso': sinalizacaoDeAcesso,
    'sinalizacao_turistica': sinalizacaoTuristica,
    'posto_de_combustivel': postoDeCombustivel,
    'outros_servicos': outrosServicos,
    'estruturas_ao_longo_da_via': estruturasAoLongoDaVia,
    'poluicao': poluicao,
    'poluicao_especificacao': poluicaoEspecificacao,
    'lixo': lixo,
    'lixo_especificacao': lixoEspecificacao,
    'desmatamento': desmatamento,
    'desmatamento_especificacao': desmatamentoEspecificacao,
    'queimadas': queimadas,
    'queimadas_especificacao': queimadasEspecificacao,
    'inseguranca': inseguranca,
    'inseguranca_especificacao': insegurancaEspecificacao,
    'extrativismo': extrativismo,
    'extrativismo_especificacao': extrativismoEspecificacao,
    'prostituicao': prostituicao,
    'prostituicao_especificacao': prostituicaoEspecificacao,
    'ocupacao_irregular_invasao': ocupacaoIrregularInvasao,
    'ocupacao_irregular_invasao_especificacao':
        ocupacaoIrregularInvasaoEspecificacao,
    'outras': outras,
    'outras_especificacao': outrasEspecificacao,
    'estado_geral_de_conservacao': estadoGeralDeConservacao,
    'observacoes': observacoes,
    'referencias': referencias,
    'nome_pesquisador': nomePesquisador,
    'telefone_pesquisador': telefonePesquisador,
    'email_pesquisador': emailPesquisador,
    'nome_coordenador': nomeCoordenador,
    'telefone_coordenador': telefoneCoordenador,
    'email_coordenador': emailCoordenador,
    };
  }
}