class Pesquisa {
  int? id;
  int? adminId;
  String? adminEmail;
  String? adminTelefone;
  List<int> userId;
  String codigoIBGE;
  String estado;
  String municipio;
  String dataInicio;
  String dataTermino;
  int? quantidadeLocais;
  int quantidadePesquisadores;
  String status;

  Pesquisa({
    required this.id,
    required this.adminId,
    required this.userId,
    required this.codigoIBGE,
    required this.estado,
    required this.municipio,
    required this.dataInicio,
    required this.dataTermino,
    required this.quantidadeLocais,
    required this.quantidadePesquisadores,
    required this.status,
     this.adminEmail,
     this.adminTelefone
  });

  // Método para criar uma instância de Pesquisa a partir de JSON
  Pesquisa.fromJson(Map<String, dynamic> json):
        id = json['id'] as int?,
        adminId = json['admin'] as int?,
        adminEmail = json['admin_email'],       // Adicionado
        adminTelefone = json['admin_telefone'],
        userId = List<int>.from(json['usuario'] ?? []),
        codigoIBGE = json['codigoIBGE'],
        estado = json['estado'],
        municipio = json['municipio'],
        dataInicio = json['dataInicio'],
        dataTermino = json['dataTermino'],
        quantidadeLocais = json['quantidadeLocais'] as int?,
        quantidadePesquisadores = json['quantidadePesquisadores'],
        status = json['status'];

  // Método para converter uma instância de Pesquisa em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admin': adminId,
      'usuario': userId,
      'codigoIBGE': codigoIBGE,
      'estado': estado,
      'municipio': municipio,
      'dataInicio': dataInicio,
      'dataTermino': dataTermino,
      'quantidadeLocais': quantidadeLocais,
      'quantidadePesquisadores': quantidadePesquisadores,
      'status': status,
    };
  }

  Pesquisa copyWith({required String dataInicio, required String dataTermino, required String codigoIBGE, required String estado, required String municipio, required List<int?> pesquisadores}) {
    return Pesquisa(
      id: id,
      adminId: adminId,
      adminEmail: adminEmail,
      adminTelefone: adminTelefone,
      userId: userId,
      codigoIBGE: codigoIBGE,
      estado: estado,
      municipio: municipio,
      dataInicio: dataInicio,
      dataTermino: dataTermino,
      quantidadeLocais: quantidadeLocais,
      quantidadePesquisadores: quantidadePesquisadores,
      status: status,
    );
  }
}
