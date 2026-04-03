import 'package:sistur/services/secure_storage_service.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'dart:convert';

/// Refreshes the access token using the refresh token stored in SecureStorage.
/// Note: This is mostly handled by ApiService/InterceptorService now.
Future<void> refreshAcessToken() async {
  final secureStorage = SecureStorageService();
  String? refreshToken = await secureStorage.read('refresh_token');

  if (refreshToken == null) {
    print("Refresh token não encontrado no SecureStorage.");
    return;
  }

  try {
    final response = await ApiService().post(
      'api/token/refresh/',
      data: {'refresh': refreshToken},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data;
      String newAcessToken = responseData['access'];

      await secureStorage.write('access_token', newAcessToken);
      print("Novo access token obtido e armazenado via SecureStorage.");
    } else {
      print("Erro ao renovar o token: ${response.statusCode}");
    }
  } catch (e) {
    print("Erro ao tentar renovar o access token: $e");
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