class UserModel {
  String nome;
  String email;
  String cpf;
  String status;
  bool isSelected = false;
  
  UserModel({
    required this.nome,
    required this.cpf,
    required this.email,
    required this.status
  });
}