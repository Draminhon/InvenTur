class PesquisaModel {
  final int codigoIBGE;
  final String estado;
  final String municipio;
  final String dataInicio;
  final String dataTermino;
  final int quantidadeLocais;
  final int quantidadePesquisadores;

  PesquisaModel({
    required this.codigoIBGE,
    required this.estado,
    required this.municipio,
    required this.dataInicio,
    required this.dataTermino,
    required this.quantidadeLocais,
    required this.quantidadePesquisadores,
  });
}