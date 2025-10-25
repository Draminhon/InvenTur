import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventur/main.dart';
import 'package:inventur/ui/screens/auth%20screens/login_page.dart';
import 'package:inventur/utils/app_constants.dart'; // Certifique-se que o caminho está correto
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiService {
  final Dio _dio = Dio();
  static const String _baseUrl = AppConstants.BASE_URI;
  bool _isDialogShowing = false;

  ApiService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // URLs que não precisam de token (como login, registro)
          if (options.path.contains('/login')) {
            // Verificação simplificada
            return handler.next(options);
          }

          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token');
          final accessTokenExp = prefs.getInt('access_token_exp');

          if (accessToken == null) {
            print("Nenhum token encontrado. Rejeitando a requisição.");
            return handler.reject(
              DioException(requestOptions: options, error: "Não autenticado"),
              true, // Use 'true' para propagar a exceção
            );
          }

          // Checa se o token expirou
          final bool isExpired = JwtDecoder.isExpired(accessToken);

          if (isExpired) {
            print("Token expirado. Deslogando o usuário...");
            _handleSessionExpiration();
            // 1. Limpa todos os dados salvos
            await _logoutUser(prefs);

            // 2. Rejeita a requisição para que a chamada original falhe
            return handler.reject(
              DioException(requestOptions: options, error: "Sessão expirada"),
              true,
            );
          }

          // Se o token NÃO expirou, continua normalmente
          print("Token válido. Prosseguindo com a requisição.");
          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Você pode adicionar uma lógica aqui para, por exemplo,
          // verificar se o erro é de "Sessão expirada" e redirecionar
          // para a tela de login.
          print("Erro na requisição: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }
  Future<void> _handleSessionExpiration() async {
    // Se um diálogo já estiver sendo exibido, não faça nada.
    if (_isDialogShowing) return;

    _isDialogShowing = true;

    // Usa o contexto do Navigator para mostrar o diálogo
    final context = navigatorKey.currentContext;
    if (context != null) {
      showDialog(
        context: context,
        // Impede o usuário de fechar o diálogo tocando fora
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return const AlertDialog(
            title: Text('Sessão Expirada'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Sua sessão terminou. Redirecionando para o login...'),
              ],
            ),
          );
        },
      );

      // Aguarda um momento para o usuário ver a mensagem
      await Future.delayed(const Duration(seconds: 2));

      // Limpa os dados do usuário
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Navega para a tela de login, removendo todas as outras telas
      // A navegação irá remover o diálogo automaticamente.
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginPage()), // Sua tela de login
        (Route<dynamic> route) => false,
      );
    }

    // Reseta a flag após a conclusão
    _isDialogShowing = false;
  }

  /// Função auxiliar para limpar os dados do usuário.
  Future<void> _logoutUser(SharedPreferences prefs) async {
    await prefs
        .clear(); // Remove todos os dados (token, refresh token, dados do usuário, etc.)
  }

  // Métodos para fazer as chamadas
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, dynamic data) {
    return _dio.post(path, data: data);
  }
}
