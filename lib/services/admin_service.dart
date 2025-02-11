import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  static Future<String> getAdminName(int adminId) async {
    var url = Uri.parse(AppConstants.BASE_URI + '/api/v1/admin/$adminId');
    final response = await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200){
      final Map<String, dynamic> data = json.decode(response.body);
      return data['username'];
    }else{
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