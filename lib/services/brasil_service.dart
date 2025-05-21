import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventur/models/endereco/estado_model.dart';
import 'package:inventur/models/endereco/municipio_model.dart';
import 'package:inventur/models/endereco/pais_model.dart';

class BrasilService {
  
  Future<List<Pais>> fetchPaises() async{
    try{
      final response = await http.get(
        Uri.parse('https://servicodados.ibge.gov.br/api/v1/localidades/paises')
      );

      if(response.statusCode == 200){
        final jsonList = jsonDecode(response.body) as List;
        return jsonList.map((item) => Pais.fromJson(item)).toList();
      }else{
        return [];
      }

    }catch(e){
      print('Erro ao carregar os estados $e');
      return [];
    }
  }

  

  Future<List<Estado>> fetchEstados() async {
    try{
    final response = await http.get(
      Uri.parse('https://servicodados.ibge.gov.br/api/v1/localidades/estados')
    );

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;

      return jsonList.map((item) => Estado.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao Carregar Estados');
    }
  }catch(e){
      //throw Exception('Falha ao carregar estados');
      print('Erro ao carregar os estados $e');
      return [];
  }}

  Future<List<Municipio>> fetchMunicipiosUF(int ufId) async {
    final response = await http.get(
      Uri.parse('https://servicodados.ibge.gov.br/api/v1/localidades/estados/$ufId/municipios')
    );

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      
      return jsonList.map((item) => Municipio.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao Carregar Municípios');
    }
  }
}