class GuiamentoEConducaoTurististicaModel {
  int? id;
  int? usuario_criador;
  String? tipoFormulario;
  String? uf;
  String? regiaoTuristica;
  String? municipio;
  String? tipo;
  List<String>? subtipos;
  String? observacoes;
  String? referencias;
  String? nomePesquisador;
  String? telefonePesquisador;
  String? emailPesquisador;
  String? nomeCoordenador;
  String? telefoneCoordenador;
  String? emailCoordenador;
  List<ContatoInfoModel>? contatos;
  List<ServicoEspecializadoInfoModel>? servicosEspecializados;

  GuiamentoEConducaoTurististicaModel({
    this.id,
    this.usuario_criador,
    this.tipoFormulario,
    this.uf,
    this.subtipos,
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
    this.contatos,
    this.servicosEspecializados,
  });

  // Método para converter JSON em objeto
  GuiamentoEConducaoTurististicaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario_criador = json['usuario_criador'];
    tipoFormulario = json['tipo_formulario'];
    uf = json['uf'];
    regiaoTuristica = json['regiao_turistica'];
    municipio = json['municipio'];
    tipo = json['tipo'];
    subtipos = List<String>.from(json['subtipos'] ?? []);
    observacoes = json['observacoes'];
    referencias = json['referencias'];
    nomePesquisador = json['nome_pesquisador'];
    telefonePesquisador = json['telefone_pesquisador'];
    emailPesquisador = json['email_pesquisador'];
    nomeCoordenador = json['nome_coordenador'];
    telefoneCoordenador = json['telefone_coordenador'];
    emailCoordenador = json['email_coordenador'];

    if (json['contatos'] != null) {
      contatos = <ContatoInfoModel>[];
      json['contatos'].forEach((v) {
        contatos!.add(ContatoInfoModel.fromJson(v));
      });
    }
    if (json['servicos_especializados'] != null) {
      servicosEspecializados = <ServicoEspecializadoInfoModel>[];
      json['servicos_especializados'].forEach((v) {
        servicosEspecializados!.add(ServicoEspecializadoInfoModel.fromJson(v));
      });
    }
  }

  // Método para converter objeto em JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['usuario_criador'] = usuario_criador;
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

    if (contatos != null) {
      data['contatos'] = contatos!.map((v) => v.toJson()).toList();
    }
    if (servicosEspecializados != null) {
      data['servicos_especializados'] =
          servicosEspecializados!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContatoInfoModel {
 String? nome_completo;
  String? cpf;
  String? email;
  String? endereco;
  String? telefone;

  ContatoInfoModel({
    this.nome_completo,
    this.cpf,
    this.email,
    this.endereco,
    this.telefone
  });

  ContatoInfoModel.fromJson(Map<String, dynamic> json) {
    nome_completo = json['nome_completo'];
    cpf = json['cpf'];
    email = json['email'];
    endereco = json['endereco'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome_completo'] = nome_completo;
    data['cpf'] = cpf;
    data['email'] = email;
    data['endereco'] = endereco;
    data['telefone'] = telefone;
    return data;
  }
}

class ServicoEspecializadoInfoModel {
  String? escolaridade;
  String? servicos_especializados_formulario;
  String? numero_cadastur;
  String? outras_informacoes;
  String? outros_cadastros;
  ServicoEspecializadoInfoModel({
    this.escolaridade,
    this.servicos_especializados_formulario,
    this.numero_cadastur,
    this.outras_informacoes,
    this.outros_cadastros
  });

  // CORRIGIDO
  ServicoEspecializadoInfoModel.fromJson(Map<String, dynamic> json) {
    escolaridade = json['escolaridade'];
    servicos_especializados_formulario = json['servicos_especializados_formulario']; // <-- Chave correta é 'servicos_especializados_formulario'
    numero_cadastur = json['numero_cadastur'];
    outras_informacoes = json['outras_informacoes'];
    outros_cadastros = json['outros_cadastros'];
  }

  // CORRIGIDO
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['escolaridade'] = escolaridade;
    data['servicos_especializados_formulario'] = servicos_especializados_formulario; // <-- Chave correta é 'servicos_especializados_formulario'
    data['numero_cadastur'] = numero_cadastur;
    data['outras_informacoes'] = outras_informacoes;
    data['outros_cadastros'] = outros_cadastros;
    return data;
  }
}
