class Pesquisa {
  int codigoIBGE;
  String estado;
  String municipio;
  String dataInicio;
  String dataTermino;
  int quantidadeLocais;
  int quantidadePesquisadores;
  String status;

  Pesquisa({
    required this.codigoIBGE,
    required this.estado,
    required this.municipio,
    required this.dataInicio,
    required this.dataTermino,
    required this.quantidadeLocais,
    required this.quantidadePesquisadores,
    required this.status
  });
}