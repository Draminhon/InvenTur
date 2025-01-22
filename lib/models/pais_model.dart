class Pais{
  final String nome;

  Pais({
    required this.nome,
  });

  factory Pais.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'nome': String nome,
      } =>
        Pais(
          nome: nome,
        ),
      _ => throw const FormatException('Falha ao Carregar País.'),
    };
  }
}