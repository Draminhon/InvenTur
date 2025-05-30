class User {
  int? id;
  String CPF = '';
  String username = '';
  String email = '';
  String status = '';
  String accessLevel = '';
   bool isSelected = false;
  String telefone = '';
  
  User({
    this.id,
    this.status = '',
    this.CPF = '',
    this.username = '',
     this.email = '',
     this.accessLevel = '',
    this.telefone = '',
  });
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    CPF = json['CPF'];
    username = json['username'];
    email = json['email'];
    accessLevel = json['acessLevel'];
    status = json['status'];
    telefone = json['telefone'];
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'CPF': CPF,
      'email': email,
      'accessLevel': accessLevel,
      'status': status,
    };
  }
}
