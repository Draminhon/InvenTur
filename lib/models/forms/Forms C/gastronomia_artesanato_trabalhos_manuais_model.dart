class GastronomiaArtesanatoTrabalhosManuaisModel {
  int? id;
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
  String? nomeProduto;
  String? historicoProduto01;
  String? historicoProduto02;
  String? historicoProduto03;
  String? historicoProduto04;
  String? modoPreparo01;
  String? modoPreparo02;
  String? modoPreparo03;
  String? modoPreparo04;
  
  Map<String, dynamic>? tabelaEquipamentoEEspaco;
  Map<String, dynamic>? tabelaEquipamentoEEspaco2;
  String? doEquipamentoEspaco;
  String? daAreaOuEdificacaoEmQueEstaLocalizado;

  String? integraRoteiros;
  String? integraGuiaTuristico;
  String? roteiro1;
  String? siteRoteiro1;
  String? roteiro2;
  String? siteRoteiro2;
  String? roteiro3;
  String? siteRoteiro3;
  String? roteiro4;
  String? siteRoteiro4;
  String? roteiro5;
  String? siteRoteiro5;
  String? Guia1;
  String? siteGuia1;
  String? Guia2;
  String? siteGuia2;
  String? Guia3;
  String? siteGuia3;
  String? Guia4;
  String? siteGuia4;
  String? Guia5;
  String? siteGuia5;
  List<String>? locaisDeComercializacao;
  String? descritivoEspecialidades;
  GastronomiaArtesanatoTrabalhosManuaisModel({
     this.integraRoteiros,
     this.locaisDeComercializacao,
     this.descritivoEspecialidades,
       this.tabelaEquipamentoEEspaco,
  this.tabelaEquipamentoEEspaco2,
  this.doEquipamentoEspaco,
  this.daAreaOuEdificacaoEmQueEstaLocalizado,
    this.integraGuiaTuristico,
    this.roteiro1,
    this.siteRoteiro1,
    this.roteiro2,
    this.siteRoteiro2,
    this.roteiro3,
    this.siteRoteiro3,
    this.roteiro4,
    this.siteRoteiro4,
    this.roteiro5,
    this.siteRoteiro5,
    this.Guia1,
    this.siteGuia1,
    this.Guia2,
    this.siteGuia2,
    this.Guia3,
    this.siteGuia3,
    this.Guia4,
    this.siteGuia4,
    this.Guia5,
    this.siteGuia5,
    this.id,
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
    this.nomeProduto,
    this.historicoProduto01,
    this.historicoProduto02,
    this.historicoProduto03,
    this.historicoProduto04,
    this.modoPreparo01,
    this.modoPreparo02,
    this.modoPreparo03,
    this.modoPreparo04,
  });

  // Método para converter JSON em objeto
  GastronomiaArtesanatoTrabalhosManuaisModel.fromJson(
      Map<String, dynamic> json) {
tabelaEquipamentoEEspaco =
        Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco'] ?? {});
    tabelaEquipamentoEEspaco2 =
        Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco2'] ?? {});
  doEquipamentoEspaco = json['doEquipamentoEspaco'];
  daAreaOuEdificacaoEmQueEstaLocalizado = json['daAreaOuEdificacaoEmQueEstaLocalizado'];
        locaisDeComercializacao = List<String>.from(json['locaisDeComercializacao'] ??[]);
        descritivoEspecialidades = json['descritivoEspecialidades'];
         integraRoteiros= json['integraRoteiros'];
        integraGuiaTuristico= json['integraGuiaTuristico'];
        roteiro1= json['roteiro1'];
        siteRoteiro1= json['siteRoteiro1'];
        roteiro2= json['roteiro2'];
        siteRoteiro2= json['siteRoteiro2'];
        roteiro3= json['roteiro3'];
        siteRoteiro3= json['siteRoteiro3'];
        roteiro4= json['roteiro4'];
        siteRoteiro4= json['siteRoteiro4'];
        roteiro5= json['roteiro5'];
        siteRoteiro5= json['siteRoteiro5'];
        Guia1= json['Guia1'];
        siteGuia1= json['siteGuia1'];
        Guia2= json['Guia2'];
        siteGuia2= json['siteGuia2'];
        Guia3= json['Guia3'];
        siteGuia3= json['siteGuia3'];
        Guia4= json['Guia4'];
        siteGuia4= json['siteGuia4'];
        Guia5= json['Guia5'];
        siteGuia5= json['siteGuia5'];
    id = json['id'];
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
    nomeProduto = json['nomeProduto'];
    historicoProduto01 = json['historicoProduto01'];
    historicoProduto02 = json['historicoProduto02'];
    historicoProduto03 = json['historicoProduto03'];
    historicoProduto04 = json['historicoProduto04'];
    modoPreparo01 = json['modoPreparo01'];
    modoPreparo02 = json['modoPreparo02'];
    modoPreparo03 = json['modoPreparo03'];
    modoPreparo04 = json['modoPreparo04'];
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
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descritivoEspecialidades'] = descritivoEspecialidades;
        data['integraRoteiros']= integraRoteiros;
        data['integraGuiaTuristico']= integraGuiaTuristico;
        data['roteiro1']= roteiro1;
        data['siteRoteiro1']= siteRoteiro1;
        data['roteiro2']= roteiro2;
        data['siteRoteiro2']= siteRoteiro2;
        data['roteiro3']= roteiro3;
        data['siteRoteiro3']= siteRoteiro3;
        data['roteiro4']= roteiro4;
        data['siteRoteiro4']= siteRoteiro4;
        data['roteiro5']= roteiro5;
        data['siteRoteiro5']= siteRoteiro5;
        data['Guia1']= Guia1;
        data['siteGuia1']= siteGuia1;
        data['Guia2']= Guia2;
        data['siteGuia2']= siteGuia2;
        data['Guia3']= Guia3;
        data['siteGuia3']= siteGuia3;
        data['Guia4']= Guia4;
        data['siteGuia4']= siteGuia4;
        data['Guia5']= Guia5;
        data['siteGuia5']= siteGuia5;
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
    data['nomeProduto'] = nomeProduto;
    data['historicoProduto01'] = historicoProduto01;
    data['historicoProduto02'] = historicoProduto02;
    data['historicoProduto03'] = historicoProduto03;
    data['historicoProduto04'] = historicoProduto04;
    data['modoPreparo01'] = modoPreparo01;
    data['modoPreparo02'] = modoPreparo02;
    data['modoPreparo03'] = modoPreparo03;
    data['modoPreparo04'] = modoPreparo04;
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
  String? atelie_aberto;
  String? email;
  String? endereco;
  String? telefone;

  ContatoInfoModel(
      {this.nome_completo,
      this.atelie_aberto,
      this.email,
      this.endereco,
      this.telefone});

  ContatoInfoModel.fromJson(Map<String, dynamic> json) {
    nome_completo = json['nome_completo'];
    atelie_aberto = json['atelie_aberto'];
    email = json['email'];
    endereco = json['endereco'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome_completo'] = nome_completo;
    data['atelie_aberto'] = atelie_aberto;
    data['email'] = email;
    data['endereco'] = endereco;
    data['telefone'] = telefone;
    return data;
  }
}

class ServicoEspecializadoInfoModel {
  String? ano_inicio_atividade;
  String? premiacao;
  String? outras_informacoes;
  ServicoEspecializadoInfoModel({
    this.ano_inicio_atividade,
    this.premiacao,
    this.outras_informacoes,
  });

  // CORRIGIDO
  ServicoEspecializadoInfoModel.fromJson(Map<String, dynamic> json) {
    ano_inicio_atividade = json['ano_inicio_atividade'];
    premiacao = json['premiacao']; // <-- Chave correta é 'premiacao'
    outras_informacoes = json['outras_informacoes'];
  }

  // CORRIGIDO
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['premiacao'] = premiacao; // <-- Chave correta é 'premiacao'
    data['outras_informacoes'] = outras_informacoes;
    data['ano_inicio_atividade'] = ano_inicio_atividade;
    return data;
  }
}
