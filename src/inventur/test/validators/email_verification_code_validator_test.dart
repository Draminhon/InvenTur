import 'package:flutter_test/flutter_test.dart';

class EmailVerificationCodeValidator {
  validate({String? code}) {
    if (code == null || code == '') return 'O código deve ser informado';

    int intCode;
    try {
      intCode = int.parse(code);
    } catch (e) {
      return 'O código é formado apenas por números';
    }
  }
}

void main() {
  late EmailVerificationCodeValidator emailVerificationCodeValidator;

  setUp(() {
    emailVerificationCodeValidator = EmailVerificationCodeValidator();
  });

  group(
    'Validação do código de verificação de e-mail',
    () {
      test(
        'deve retornar uma mensagem de erro caso o código seja null', 
        () {
          final result = emailVerificationCodeValidator.validate();

          expect(result, 'O código deve ser informado');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso o código seja vazio', 
        () {
          final result = emailVerificationCodeValidator.validate();

          expect(result, 'O código deve ser informado');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso o código não seja numérico', 
        () {
          final result = emailVerificationCodeValidator.validate(code: 'asfsd');

          expect(result, 'O código é formado apenas por números');
        }
      );
    },
  );
}
