import 'package:flutter_test/flutter_test.dart';
import 'package:inventur/validators/password_validator.dart';

void main() {
  late PasswordValidator passwordValidator;

  setUp(() {
    passwordValidator = PasswordValidator();
  });

  group(
    'Validação da senha',
    () {
      test(
        'deve retornar uma mensagem de erro caso a senha seja null',
        () {
          final result = passwordValidator.validate();

          expect(result, 'A senha deve ser informada');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso a senha seja vazia',
        () {
          final result = passwordValidator.validate(password: '');

          expect(result, 'A senha deve ser informada');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso a senha seja menor que 8 caracteres',
        () {
          final result = passwordValidator.validate(password: 'senha');

          expect(result, 'A senha deve possuir pelo menos 8 caracteres');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso a senha não seja alfanumérica',
        () {
          final result = passwordValidator.validate(password: '#SeNha@_');

          expect(result, 'A senha deve ser alfanumérica');
        },
      );
      test(
        'deve retornar null caso a senha seja válida',
        () {
          final result = passwordValidator.validate(password: 'HU52sLnL@');

          expect(result, isNull);
        },
      );
    },
  );
}
