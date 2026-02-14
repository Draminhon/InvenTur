import 'package:flutter_test/flutter_test.dart';
import 'package:sistur/validators/email_validator.dart';

void main() {
  late EmailValidator emailValidator;

  setUp(() {
    emailValidator = EmailValidator();
  });

  group(
    'Validação do e-mail',
    () {
      test(
        'deve retornar uma mensagem de erro caso o e-mail seja null',
        () {
          final result = emailValidator.validate();

          expect(result, 'O e-mail deve ser informado');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso o e-mail seja vazio',
        () {
          final result = emailValidator.validate(email: '');

          expect(result, 'O e-mail deve ser informado');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso o e-mail seja inválido',
        () {
          final result = emailValidator.validate(email: 'teste');

          expect(result, 'O e-mail é inválido');
        },
      );
      test(
        'deve retornar null caso o e-mail seja válido',
        () {
          final result = emailValidator.validate(email: 'e-mail@teste.com');

          expect(result, isNull);
        },
      );
    },
  );
}
