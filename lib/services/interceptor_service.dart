import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sistur/main.dart';
import 'package:sistur/ui/screens/auth%20screens/login_page.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sistur/services/secure_storage_service.dart';

/// Resultado de uma tentativa de renovar a sessão.
enum _Renovacao {
  /// Tokens novos gravados.
  ok,

  /// O servidor recusou o refresh token (vencido, revogado, conta excluída): aí sim a sessão acabou.
  sessaoInvalida,

  /// Sem resposta do servidor (sem internet, timeout, servidor fora): a sessão continua válida.
  semConexao,
}

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final Dio _dio = Dio();
  static const String _baseUrl = AppConstants.BASE_URI;
  bool _isDialogShowing = false;

  /// Renova um pouco ANTES de vencer: relógio do aparelho adiantado e o tempo da requisição na rede
  /// fariam o token chegar vencido ao servidor.
  static const Duration _margemExpiracao = Duration(seconds: 30);

  /// Renovação em andamento. O servidor gira o refresh token a cada renovação e bloqueia o anterior
  /// (ROTATE_REFRESH_TOKENS + BLACKLIST_AFTER_ROTATION): duas renovações simultâneas com o mesmo token
  /// fazem a segunda ser recusada — e o app deslogava o usuário com a sessão ainda válida. Por isso
  /// só existe UMA renovação por vez; quem chegar durante ela espera o mesmo resultado.
  Future<_Renovacao>? _renovacaoEmAndamento;

  ApiService._internal() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // URLs que não precisam de token
          if (options.path.contains(AppConstants.LOGIN_URI) ||
              options.path.contains(AppConstants.REFRESH_TOKEN_URI) ||
              options.path.contains('password-reset/') ||
              (options.path == AppConstants.REGISTER_URI && options.method == 'POST') ||
              options.path.contains(AppConstants.VERIFICAR_EMAIL_URI)) {
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

          if (_venceEmBreve(accessToken)) {
            final resultado = await _renovarSessao();
            if (resultado == _Renovacao.ok) {
              accessToken = await secureStorage.read('access_token');
            } else {
              return handler.reject(_erroDeSessao(options, resultado), true);
            }
          }

          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          final opts = e.requestOptions;
          // 401 do servidor: renova e repete a requisição UMA vez (marcada para não entrar em loop)
          if (e.response?.statusCode == 401 &&
              !opts.path.contains(AppConstants.LOGIN_URI) &&
              !opts.path.contains(AppConstants.REFRESH_TOKEN_URI) &&
              opts.extra['repetida_apos_renovar'] != true) {
            final secureStorage = SecureStorageService();
            final tokenUsado = (opts.headers['Authorization'] as String?)?.replaceFirst('Bearer ', '');
            final tokenAtual = await secureStorage.read('access_token');

            // Outra requisição já renovou enquanto esta estava na rede: só repete com o token novo
            _Renovacao resultado = _Renovacao.ok;
            if (tokenAtual == null || tokenAtual == tokenUsado || _venceEmBreve(tokenAtual)) {
              resultado = await _renovarSessao();
            }
            if (resultado != _Renovacao.ok) {
              return handler.next(resultado == _Renovacao.semConexao ? _erroDeSessao(opts, resultado) : e);
            }
            try {
              opts.headers['Authorization'] = 'Bearer ${await secureStorage.read('access_token')}';
              opts.extra['repetida_apos_renovar'] = true;
              return handler.resolve(await _dio.fetch(opts));
            } on DioException catch (erro) {
              return handler.next(erro);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  bool _venceEmBreve(String token) {
    try {
      return JwtDecoder.getRemainingTime(token) <= _margemExpiracao;
    } catch (_) {
      return true; // token ilegível: tenta renovar
    }
  }

  /// Erro devolvido quando a renovação não deu certo. Sem conexão, é um erro de conexão comum (sem resposta):
  /// os fluxos offline tratam normalmente (ex.: o formulário vai para a fila). Sessão recusada: desloga.
  DioException _erroDeSessao(RequestOptions options, _Renovacao resultado) {
    if (resultado == _Renovacao.sessaoInvalida) {
      _handleSessionExpiration();
      return DioException(requestOptions: options, error: "Sessão expirada");
    }
    return DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
      error: "Sem conexão para renovar a sessão",
    );
  }

  /// Uma renovação por vez (ver _renovacaoEmAndamento).
  Future<_Renovacao> _renovarSessao() {
    return _renovacaoEmAndamento ??= _refreshToken().whenComplete(() => _renovacaoEmAndamento = null);
  }

  Future<_Renovacao> _refreshToken() async {
    final secureStorage = SecureStorageService();
    final refreshToken = await secureStorage.read('refresh_token');
    if (refreshToken == null) return _Renovacao.sessaoInvalida;

    try {
      // Instância limpa do Dio para não passar pelos interceptores (evita loop)
      final response = await Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      )).post(
        _baseUrl + AppConstants.REFRESH_TOKEN_URI,
        data: {'refresh': refreshToken},
      );
      final String newAccess = response.data['access'];
      final String? newRefresh = response.data['refresh'];
      await secureStorage.write('access_token', newAccess);
      if (newRefresh != null) await secureStorage.write('refresh_token', newRefresh);
      debugPrint("Tokens renovados com sucesso.");
      return _Renovacao.ok;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      // Só o servidor RECUSANDO o refresh encerra a sessão. Sem internet/timeout/servidor fora, não.
      if (status == 401 || status == 400) {
        debugPrint("Refresh recusado pelo servidor ($status): sessão encerrada.");
        return _Renovacao.sessaoInvalida;
      }
      debugPrint("Sem conexão para renovar a sessão (${e.type}); a sessão continua.");
      return _Renovacao.semConexao;
    } catch (e) {
      debugPrint("Erro ao renovar token: $e");
      return _Renovacao.semConexao;
    }
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
