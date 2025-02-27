import 'package:flutter_test/flutter_test.dart';
import 'package:inventur/services/email_verification_code_service.dart';
import 'package:inventur/validators/email_verification_code_validator.dart';

void main() {
  String expectedCode;
  late EmailVerificationCode emailVerificationCodeGenerator;
  late EmailVerificationCodeValidator emailVerificationCodeValidator;

  setUp(() {
    emailVerificationCodeGenerator = EmailVerificationCode();
    emailVerificationCodeValidator = EmailVerificationCodeValidator();
  });

  group(
    'Validação do código de verificação de e-mail',
    () {
      test(
        'deve retornar uma mensagem de erro caso o código seja null', 
        () {
          final result = emailVerificationCodeValidator.validate(expectedCode: '');

          expect(result, 'O código deve ser informado');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso o código seja vazio', 
        () {
          final result = emailVerificationCodeValidator.validate(expectedCode: '');

          expect(result, 'O código deve ser informado');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso o código não seja numérico', 
        () {
          final result = emailVerificationCodeValidator.validate(code: 'asfsds', expectedCode: '');

          expect(result, 'O código é formado apenas por números');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso a quantidade de digitos do código seja menor do que seis', 
        () {
          final result = emailVerificationCodeValidator.validate(code: '01025', expectedCode: '');

          expect(result, 'O código é formado por 6 dígitos');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso o código informado seja diferente do esperado', 
        () {
          expectedCode = emailVerificationCodeGenerator.generateVerificationCode();
          final result = emailVerificationCodeValidator.validate(code: '010250', expectedCode: expectedCode);

          expect(result, 'Código inválido');
        }
      );
      test(
        'deve retornar null caso o código seja válido', 
        () {
          expectedCode = emailVerificationCodeGenerator.generateVerificationCode();
          final result = emailVerificationCodeValidator.validate(code: expectedCode, expectedCode: expectedCode);

          expect(result, isNull);
        }
      );
    },
  );
}
