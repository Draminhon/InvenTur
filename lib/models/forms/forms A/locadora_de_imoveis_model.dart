class LocadoraDeImoveisModel {
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
  List<ContatoInfoModel>? contatos;
  List<ServicoEspecializadoInfoModel>? servicosEspecializados;

  LocadoraDeImoveisModel({
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
    this.contatos,
    this.servicosEspecializados,
  });

  // Método para converter JSON em objeto
  LocadoraDeImoveisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario_criador = json['usuario_criador'];
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
 String? razao_social;
  String? nome_fantasia;
  String? cnpj;
  String? endereco;
  String? telefone;

  ContatoInfoModel({
    this.razao_social,
    this.nome_fantasia,
    this.cnpj,
    this.endereco,
    this.telefone
  });

  ContatoInfoModel.fromJson(Map<String, dynamic> json) {
    razao_social = json['razao_social'];
    nome_fantasia = json['nome_fantasia'];
    cnpj = json['cnpj'];
    endereco = json['endereco'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['razao_social'] = razao_social;
    data['nome_fantasia'] = nome_fantasia;
    data['cnpj'] = cnpj;
    data['endereco'] = endereco;
    data['telefone'] = telefone;
    return data;
  }
}

class ServicoEspecializadoInfoModel {
  String? email;
  String? site;
  String? tipoImoveis;
  String? outrasInfo;

  ServicoEspecializadoInfoModel({
    this.email,
    this.site,
    this.tipoImoveis,
    this.outrasInfo
  });

  // CORRIGIDO
  ServicoEspecializadoInfoModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    site = json['site']; // <-- Chave correta é 'site'
    tipoImoveis = json['tipoImoveis'];
    outrasInfo = json['outrasInfo'];
  }

  // CORRIGIDO
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['site'] = site; // <-- Chave correta é 'site'
    data['tipoImoveis'] = tipoImoveis;
    data['outrasInfo'] = outrasInfo;
    return data;
  }
}
