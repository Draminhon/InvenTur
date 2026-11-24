import 'package:sistur/utils/app_constants.dart';

class User {
  int? id;
  String username = '';
  String email = '';
  String status = '';
  String accessLevel = '';
  bool isSelected = false;
  String telefone = '';
  String? fotoPerfil;
  String? fotoPerfilBase64;
  /// Pesquisas do administrador logado das quais este usuário participa (filtro da aba "Usuários")
  List<int> pesquisasIds = [];
  
  User({
    this.id,
    this.status = '',
    this.username = '',
     this.email = '',
     this.accessLevel = '',
    this.telefone = '',
    this.fotoPerfil,
    this.fotoPerfilBase64,
  });
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    accessLevel = json['acessLevel'];
    status = json['status'];
    telefone = json['telefone'];
    fotoPerfil = json['foto_perfil'];
    fotoPerfilBase64 = json['foto_perfil_base64'];
    pesquisasIds = List<int>.from(json['pesquisas_ids'] ?? []);
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'accessLevel': accessLevel,
      'status': status,
      'telefone': telefone,
      'foto_perfil': fotoPerfil,
      'foto_perfil_base64': fotoPerfilBase64,
    };
  }

  String? get fullFotoPerfilUrl {
    if (fotoPerfil == null) return null;
    if (fotoPerfil!.startsWith('http')) return fotoPerfil;
    const String baseUrl = AppConstants.BASE_URI;
    String url = baseUrl.endsWith('/api/v1/')
        ? baseUrl.substring(0, baseUrl.length - 8)
        : baseUrl;
    return '$url$fotoPerfil';
  }
}
