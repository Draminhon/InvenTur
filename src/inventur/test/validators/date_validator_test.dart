import 'package:flutter_test/flutter_test.dart';
import 'package:inventur/validators/date_validator.dart';

void main() {
  late DateValidator dateValidator;

  setUp(() {
    dateValidator = DateValidator(); 
  });

  group(
    'Validação de datas',
    () {
      test(
        'deve retornar uma mensagem de erro caso a data seja null',
        () {
          final result = dateValidator.validate();

          expect(result, 'A data deve ser informada');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso a data seja vazia',
        () {
          final result = dateValidator.validate(date: '');

          expect(result, 'A data deve ser informada');
        },
      );
      test(
        'deve retornar uma mensagem de erro caso a data seja inválida',
        () {
          final result = dateValidator.validate(date: '31/31/2019');

          expect(result, 'A data é inválida');
        },
      );
      test(
        'deve retornar null caso a data seja válida',
        () {
          final result = dateValidator.validate(date: '30/04/2000');

          expect(result, isNull);
        },
      );
    },
  );
}