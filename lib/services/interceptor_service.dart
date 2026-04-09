import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sistur/main.dart';
import 'package:sistur/ui/screens/auth%20screens/login_page.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sistur/services/secure_storage_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final Dio _dio = Dio();
  static const String _baseUrl = AppConstants.BASE_URI;
  bool _isDialogShowing = false;

  ApiService._internal() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // URLs que não precisam de token
          if (options.path.contains(AppConstants.LOGIN_URI) || 
              options.path.contains(AppConstants.REFRESH_TOKEN_URI) ||
              options.path.contains('password-reset/') ||
              (options.path == AppConstants.REGISTER_URI && options.method == 'POST')) {
            return handler.next(options);
          }

          final secureStorage = SecureStorageService();
          String? accessToken = await secureStorage.read('access_token');

          if (accessToken == null) {
            return handler.reject(
              DioException(requestOptions: options, error: "Não autenticado"),
              true,
            );
          }

          // Checa se o token expirou
          final bool isExpired = JwtDecoder.isExpired(accessToken);

          if (isExpired) {
            print("Token expirado. Tentando refresh...");
            final success = await _refreshToken();
            if (success) {
              final refreshedToken = await secureStorage.read('access_token');
              options.headers['Authorization'] = 'Bearer $refreshedToken';
              return handler.next(options);
            } else {
              print("Refresh falhou. Deslogando...");
              _handleSessionExpiration();
              return handler.reject(
                DioException(requestOptions: options, error: "Sessão expirada"),
                true,
              );
            }
          }

          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // Se o servidor retornar 401, tentamos o refresh uma última vez
          if (e.response?.statusCode == 401 && 
              !e.requestOptions.path.contains(AppConstants.LOGIN_URI)) {
            print("401 detectado no interceptor. Tentando refresh...");
            final success = await _refreshToken();
            if (success) {
              final secureStorage = SecureStorageService();
              final newToken = await secureStorage.read('access_token');
              
              // Refaz a requisição original com o novo token
              final opts = e.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newToken';
              
              final response = await _dio.fetch(opts);
              return handler.resolve(response);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final secureStorage = SecureStorageService();
      final refreshToken = await secureStorage.read('refresh_token');

      if (refreshToken == null) return false;

      // Usamos uma instância limpa do Dio para evitar interceptores em loop
      final response = await Dio().post(
        _baseUrl + AppConstants.REFRESH_TOKEN_URI,
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final String newAccess = response.data['access'];
        final String newRefresh = response.data['refresh'];

        final secureStorage = SecureStorageService();
        await secureStorage.write('access_token', newAccess);
        await secureStorage.write('refresh_token', newRefresh);
        
        print("Tokens renovados com sucesso.");
        return true;
      }
    } catch (e) {
      print("Erro ao renovar token: $e");
    }
    return false;
  }

  Future<void> _handleSessionExpiration() async {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    final context = navigatorKey.currentContext;
    if (context != null) {
      showDialog(
        context: context,
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

      await Future.delayed(const Duration(seconds: 2));
      await SecureStorageService().clearAll();

      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
    _isDialogShowing = false;
  }

  // Métodos para facilitar o uso no lugar do pacote 'http'
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) {
    return _dio.post(path, data: data, options: options);
  }

  Future<Response> patch(String path, {dynamic data, Options? options}) {
    return _dio.patch(path, data: data, options: options);
  }

  Future<Response> put(String path, {dynamic data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  Future<Response> delete(String path, {dynamic data, Options? options}) {
    return _dio.delete(path, data: data, options: options);
  }
}
