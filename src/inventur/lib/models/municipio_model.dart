class Municipio {
  final int id;
  final String nome;

  Municipio({
    required this.id,
    required this.nome,
  });

  factory Municipio.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
      } =>
        Municipio(
          id: id,
          nome: nome,
        ),
      _ => throw const FormatException('Falha ao Carregar Município.'),
    };
  }
}