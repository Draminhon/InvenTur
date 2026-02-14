import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  static Future<String> getAdminName(int adminId) async {
    if(adminId < 0){
      return "erro";
    }

    try{
    var url = Uri.parse(AppConstants.BASE_URI + 'admin/$adminId');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['username'];
    } else {
      return "administrador não encontrado";
    }
    }catch(e){
      return "administrador não encontrado";
    }

  }
  }

Future<void> savePesquisaId(int pesquisaId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('pesquisa_id', pesquisaId);
}

Future<int?> getPesquisaId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('pesquisa_id');
}

Future<void> clearPesquisaId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('pesquisa_id');
}

Future<Map<String, dynamic>> getAdminAndPesquisadorInfo() async {

  int pesquisadorId = 0;

  String pesquisadorNome = '';
  String pesquisadorTelefone = '';
  String pesquisadorEmail = '';

  String coordenadorNome = '';
  String coordenadorEmail = '';
  String coordenadorTelefone = '';

  try {
    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');

    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      pesquisadorId = userData['id'];
      pesquisadorNome = userData['name'];
      pesquisadorTelefone = userData['telefone'];
      pesquisadorEmail = userData['email'];

      print(prefs.getKeys());

      coordenadorNome = prefs.getString('adminName')!;
      coordenadorEmail = prefs.getString('adminEmail')!;
      coordenadorTelefone = prefs.getString('adminTelefone')!;
    }
  } catch (e) {
    print(e);
  }

  return {
    'pesquisador': {
      'id': pesquisadorId,
      'nome': pesquisadorNome,
      'telefone': pesquisadorTelefone,
      'email': pesquisadorEmail,
    },
    'coordenador': {
      'nome': coordenadorNome,
      'telefone': coordenadorTelefone,
      'email': coordenadorEmail
    }
  };
}
