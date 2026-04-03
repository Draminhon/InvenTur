import 'package:flutter/material.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:dio/dio.dart';
import 'package:sistur/main.dart';
import 'package:sistur/ui/widgets/widgets/sendButton.dart';
import 'package:sistur/ui/screens/updatedForm_screen.dart';
import 'package:sistur/ui/screens/sync_page.dart';
import 'package:sistur/services/admin_service.dart';
import 'package:sistur/services/sync_service.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormService {
  Future<bool> sendForm(
      Map<String, dynamic> valoresjson, String endpoint) async {
    int? pesquisaId;
    try {
      pesquisaId = await getPesquisaId();
      valoresjson['pesquisa'] = pesquisaId;
      final response = await ApiService().post(
        endpoint,
        data: valoresjson,
      ); 

      if (response.statusCode == 201) {
        debugPrint("Formulário enviado com sucesso!");
        navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (context) => const SendedFormPage()));
        return true;
      } else {
        debugPrint("ERRO AO ENVIAR O FORMULÁRIO: ${response.statusCode}");
        navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
            builder: (context) => const SendedFormErrorPage()));
        return false;
      }
    } catch (e) {
      print('Erro: $e');
      await DataSyncService()
          .enqueue(method: 'POST', endpoint: endpoint, payload: valoresjson, pesquisa_id: pesquisaId!);

      navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (context) => const SyncPage()));
      return false;
    }
  }

  Future<void> updateForm(
      int id, Map<String, dynamic> data, String endpoint) async {
    try {
      final response = await ApiService().patch(
        '$endpoint$id/',
        data: data,
      );
      if (response.statusCode == 200) {
        debugPrint("Formulário atualizado com sucesso!");
        navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (context) => const UpdatedForm()));
      } else {
        debugPrint("ERRO AO ATUALIZAR O FORMULÁRIO: ${response.statusCode}");
        navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (context) => const UpdatedFormError()));
      }
    } catch (e) {
      print('Erro: $e');
    }
  }
}