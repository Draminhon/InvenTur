class Estado {
  final int id;
  final String sigla;
  final String nome;

  Estado({
    required this.id,
    required this.sigla,
    required this.nome
  });

  factory Estado.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'sigla': String sigla,
        'nome': String nome,
      } => 
        Estado(
          id: id,
          sigla: sigla,
          nome: nome,
        ),
      _ => throw const FormatException('Falha ao Carregar Estado.'),
    };
  }
}