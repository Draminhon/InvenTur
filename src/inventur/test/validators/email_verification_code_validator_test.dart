import 'package:flutter_test/flutter_test.dart';

class EmailVerificationCodeValidator {
  validate({int? code}) {
    if (code == null) return 'O código deve ser informado';
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
    },
  );
}
