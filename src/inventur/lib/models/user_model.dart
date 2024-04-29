class User {
  String cpf;
  String nome;
  String email;
  String? status;
  String accessLevel;
  bool isSelected = false;
  
  User({
    this.status,
    required this.cpf,
    required this.nome,
    required this.email,
    required this.accessLevel,
  });
}