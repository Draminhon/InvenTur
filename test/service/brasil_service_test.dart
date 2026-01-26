import 'package:flutter_test/flutter_test.dart';
import 'package:sistur/services/brasil_service.dart';

void main() {
  late BrasilService brasilService;

  setUp(() {
    brasilService = BrasilService();
  });
  group(
    'Validação de Requests na API do IBGE',
    () {
      test(
        'deve retornar uma lista não vazia de estados',
        () async {
          final result = await brasilService.fetchEstados();

          expect(result, isNotEmpty);
        },
      );
      test(
        'deve retornar uma lista não vazia de municípios de um determinado estado',
        () async {
          final result = await brasilService.fetchMunicipiosUF(23);

          expect(result, isNotEmpty);
          
        },
      );
    },
  );
}