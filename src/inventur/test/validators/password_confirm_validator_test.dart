import 'package:flutter_test/flutter_test.dart';
import 'package:inventur/validators/password_confirm_validator.dart';

void main() {
  late PasswordConfirmValidator passwordConfirmValidator;

  setUp(() {
    passwordConfirmValidator = PasswordConfirmValidator();
  });

  group(
    'Validação da confirmação de senha',
    () {
      test(
        'deve retornar uma mensagem de erro caso a confirmação de senha seja null',
        () {
          final result = passwordConfirmValidator.validate(password: '1@RBNa#f');  

          expect(result, 'Confirme a senha');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso a confirmação de senha seja vazia',
        () {
          final result = passwordConfirmValidator.validate(passwordConfirm: '', password: '1@RBNa#f');  

          expect(result, 'Confirme a senha');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso a senha inválida',
        () {
          final result = passwordConfirmValidator.validate(passwordConfirm: '1@RBNA#f', password: 'asdsdads');  

          expect(result, 'Senha inválida');
        }
      );
      test(
        'deve retornar uma mensagem de erro caso a confirmação de senha seja diferente da senha',
        () {
          final result = passwordConfirmValidator.validate(passwordConfirm: '1@RBNA#f', password: '1@RBNa#f');  

          expect(result, 'As senhas não coincidem');
        }
      );
      test(
        'deve retornar null caso as senhas sejam iguais',
        () {
          final result = passwordConfirmValidator.validate(passwordConfirm: '1@RBNa#f', password: '1@RBNa#f');  

          expect(result, isNull);
        }
      );
    },
  );
}
