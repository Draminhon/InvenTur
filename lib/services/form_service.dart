
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormService {


    Future<void> sendForm(Map<String, dynamic> valoresjson, String endpoint) async {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');
      final url =
          Uri.parse(AppConstants.BASE_URI + endpoint);
      int? pesquisa_id = await getPesquisaId();

      try {
        valoresjson['pesquisa'] = pesquisa_id;
        final response = await http.post(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "Authorization": "Bearer $token",
            },
            body: json.encode(valoresjson));
        if (response.statusCode == 201) {
          debugPrint("Formulário enviado com sucesso!");
        } else {
          debugPrint("ERRO AO ENVIAR O FORMULÁRIO: ${response.body}");
        }
      } catch (e) {
        print('Erro: $e');
      }
    }



}