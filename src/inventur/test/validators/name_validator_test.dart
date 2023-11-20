import 'package:flutter_test/flutter_test.dart';
import 'package:inventur/validators/name_validator.dart';

void main() {
  late NameValidator nameValidator;

  setUp(() {
    nameValidator = NameValidator();
  });

  group(
    'Validação do nome',
    () {
      test(
        'deve retornar uma mensagem de erro caso o nome seja null',
        () {
          final result = nameValidator.validate();

          expect(result, equals('O nome deve ser informado'));
        },
      );
      test(
        'deve retornar uma mensagem de erro caso o nome seja vazio',
        () {
          final result = nameValidator.validate(name: '');

          expect(result, equals('O nome deve ser informado'));
        },
      );
      test(
        'deve retornar uma mensagem de erro caso o nome seja maior 250 caracteres',
        () {
          final result = nameValidator.validate(
              name:
                  'Texto para teste de validação de tamanho maximo. Texto para teste de validação de tamanho maximo. Texto para teste de validação de tamanho maximo. Texto para teste de validação de tamanho maximo. Texto para teste de validação de tamanho maximo. Texto para teste de validação de tamanho maximo.');

          expect(
              result, equals('O nome deve possuir no máximo 250 caracteres'));
        },
      );
      test(
        'deve retornar null caso o nome seja válido',
        () {
          final result = nameValidator.validate(name: 'Fulano da Silva Costa');

          expect(result, isNull);
        },
      );
    },
  );
}
