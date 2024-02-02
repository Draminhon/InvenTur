class UserModel {
  String cpf;
  String nome;
  String email;
  String? status;
  String accessLevel;
  bool isSelected = false;
  
  UserModel({
    this.status,
    required this.cpf,
    required this.nome,
    required this.email,
    required this.accessLevel,
  });
}