import 'package:dio/dio.dart';
import 'package:sistur/models/endereco/estado_model.dart';
import 'package:sistur/models/endereco/municipio_model.dart';
import 'package:sistur/models/endereco/pais_model.dart';

class BrasilService {
  final Dio _dio = Dio();
  
  Future<List<Pais>> fetchPaises() async {
    try {
      final response = await _dio.get('https://servicodados.ibge.gov.br/api/v1/localidades/paises');

      if (response.statusCode == 200) {
        final List jsonList = response.data;
        return jsonList.map((item) => Pais.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao carregar os países: $e');
      return [];
    }
  }

  Future<List<Estado>> fetchEstados() async {
    try {
      final response = await _dio.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados');

      if (response.statusCode == 200) {
        final List jsonList = response.data;
        return jsonList.map((item) => Estado.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao Carregar Estados');
      }
    } catch (e) {
      print('Erro ao carregar os estados: $e');
      return [];
    }
  }

  Future<List<Municipio>> fetchMunicipiosUF(int ufId) async {
    try {
      final response = await _dio.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados/$ufId/municipios');

      if (response.statusCode == 200) {
        final List jsonList = response.data;
        return jsonList.map((item) => Municipio.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao Carregar Municípios');
      }
    } catch (e) {
      print('Erro ao carregar os municípios: $e');
      return [];
    }
  }
}