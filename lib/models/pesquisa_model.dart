class Pesquisa {
  int id;
  int adminId;
  List<int> userId;
  String codigoIBGE;
  String estado;
  String municipio;
  String dataInicio;
  String dataTermino;
  int quantidadeLocais;
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
  });

  // Método para criar uma instância de Pesquisa a partir de JSON
  Pesquisa.fromJson(Map<String, dynamic> json):
        id = json['id'],
        adminId = json['admin'],
        userId = List<int>.from(json['usuario'] ?? []),
        codigoIBGE = json['codigoIBGE'],
        estado = json['estado'],
        municipio = json['municipio'],
        dataInicio = json['dataInicio'],
        dataTermino = json['dataTermino'],
        quantidadeLocais = json['quantidadeLocais'],
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
}
