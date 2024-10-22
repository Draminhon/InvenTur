import 'package:flutter_test/flutter_test.dart';

class AuthService {
  authenticate({String? cpf, String? password}) {
    
  }
}

void main() {
  late AuthService authService;

  setUp(() {
    authService = AuthService();
  });

  group(
    'Teste de autenticação',
    () {
      test(
        'Deve retornar uma mensagem de erro caso o usuário não seja encontrado',
        () {
          final result = authService.authenticate();

          expect(result, 'Usuário não encontrado');
        },
      );
    },
  );
}
