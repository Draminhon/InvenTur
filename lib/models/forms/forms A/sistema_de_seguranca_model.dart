class SistemaDeSegurancaModel {
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
  List<ContatoInfoModel>? contatos;
  List<ServicoEspecializadoInfoModel>? servicosEspecializados;

  SistemaDeSegurancaModel({
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
    this.contatos,
    this.servicosEspecializados,
  });

  // Método para converter JSON em objeto
  SistemaDeSegurancaModel.fromJson(Map<String, dynamic> json) {
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
  String? nome;
  String? endereco;
  String? whatsapp;
  String? email;

  ContatoInfoModel({
    this.nome,
    this.endereco,
    this.whatsapp,
    this.email,
  });

  ContatoInfoModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    endereco = json['endereco'];
    whatsapp = json['whatsapp'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['endereco'] = endereco;
    data['whatsapp'] = whatsapp;
    data['email'] = email;
    return data;
  }
}

class ServicoEspecializadoInfoModel {
  String? email;
  String? servicosEspecializados;
  String? outrasInformacoes;

  ServicoEspecializadoInfoModel({
    this.email,
    this.servicosEspecializados,
    this.outrasInformacoes,
  });

  ServicoEspecializadoInfoModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    servicosEspecializados = json['servicos_especializados'];
    outrasInformacoes = json['outras_informacoes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['servicos_especializados'] = servicosEspecializados;
    data['outras_informacoes'] = outrasInformacoes;
    return data;
  }
}
