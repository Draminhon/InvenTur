import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventur/models/estado_model.dart';
import 'package:inventur/models/municipio_model.dart';

class BrasilService {
  
  Future<List<Estado>> fetchEstados() async {
    final response = await http.get(
      Uri.parse('https://brasilapi.com.br/api/ibge/uf/v1')
    );

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;

      return jsonList.map((item) => Estado.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao Carregar Estados');
    }
  }

  Future<List<Municipio>> fetchMunicipiosUF(String uf) async {
    final response = await http.get(
      Uri.parse('https://brasilapi.com.br/api/ibge/municipios/v1/$uf?providers=dados-abertos-br,gov,wikipedia')
    );

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;

      return jsonList.map((item) => Municipio.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao Carregar Municípios');
    }
  }
}