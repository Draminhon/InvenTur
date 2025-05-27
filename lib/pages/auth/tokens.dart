import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> refreshAcessToken() async{

  final prefs = await SharedPreferences.getInstance();
  String? refreshToken = prefs.getString('refresh_token');

  if(refreshToken == null){
    print("Refresh token não encontrado. O usuário precisa fazer login novamente");
    return;
  }

  final url = Uri.parse(AppConstants.BASE_URI + 'api/token/refresh/');

  try{
    final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'refresh':  refreshToken}),
    );

    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = json.decode(response.body);
      String newAcessToken = responseData['acess'];

      await prefs.setString('acess_token', newAcessToken);
      print("Novo acess token obtido e armazenado: $newAcessToken");
    }else{
      print("Erro ao renovar o token: ${response.body}");
    }
  }catch(e){
    print("Erro ao tentar renovar o acess token: $e");
  }
}
bool isTokenExpired(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return true;

    final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    final expiry = payload['exp'] * 1000; // 'exp' está em segundos
    final now = DateTime.now().millisecondsSinceEpoch;

    return now >= expiry;
  } catch (e) {
    print("Erro ao verificar validade do token: $e");
    return true; // Considere expirado em caso de erro
  }
}