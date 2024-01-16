class UserModel {
  String nome;
  String email;
  String cpf;
  String status;
  bool isSelected;
  
  UserModel({
    this.isSelected = false,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.status
  });
}