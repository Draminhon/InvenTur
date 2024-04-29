class Municipio {
  final String nome;
  final String codigoIBGE;

  Municipio({
    required this.nome,
    required this.codigoIBGE,
  });

  factory Municipio.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'nome': String nome,
        'codigo_ibge': String codigoIBGE,
      } =>
        Municipio(
          nome: nome,
          codigoIBGE: codigoIBGE,
        ),
      _ => throw const FormatException('Falha ao Carregar Município.'),
    };
  }
}