import 'package:flutter_test/flutter_test.dart';
import 'package:inventur/validators/cpf_validator.dart';

void main() {
  late CPFValidator cpfValidator;

  setUp(() {
    cpfValidator = CPFValidator();
  });

  group(
    'Validação do CPF',
    () {
      test(
        'deve retornar uma mensagem de erro caso o CPF seja null',
        () {
          final result = cpfValidator.validate();

          expect(result, 'O CPF deve ser informado');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso o CPF seja vazio',
        () {
          final result = cpfValidator.validate(cpf: '');

          expect(result, 'O CPF deve ser informado');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso o CPF seja inválido',
        () {
          final result = cpfValidator.validate(cpf: '0000000000');

          expect(result, 'O CPF informado é inválido');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso os digitos verificadores do CPF sejam diferentes',
        () {
          final result = cpfValidator.validate(cpf: '529.982.247-24');

          expect(result, 'O CPF informado é inválido');
        },
      );
      test(
        'deve retornar null caso o CPF seja válido',
        () {
          final result = cpfValidator.validate(cpf: '529.982.247-25');

          expect(result, isNull);
        },
      );
    },
  );
}
