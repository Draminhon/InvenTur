import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistur/models/pesquisa_model.dart';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:sistur/main.dart';
import 'package:sistur/ui/screens/auth%20screens/login_page.dart';
import 'package:sistur/ui/home/Pesquisador/pesquisador_homepage.dart';

Future<void> initApp() async {
  try {
    final secureStorage = SecureStorageService();

    final String? token = await secureStorage.read("access_token");
    final String? userDataString = await secureStorage.read("user_data");

    if (token == null || token.isEmpty || userDataString == null || userDataString.isEmpty) {
      return;
    }

    final userData = jsonDecode(userDataString) as Map<String, dynamic>;
    final String? accessLevel = userData['access_level'];

    Widget destinationPage;

    switch (accessLevel) {
      case 'Pesquisador':
        destinationPage = const PesquisadorHome();
        break;
      default:
        destinationPage = LoginPage();
        break;
    }
    
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => destinationPage),
    );

  } catch (e) {
    debugPrint("Falha ao restaurar a sessão do usuário via SecureStorage: $e");
  }
}

Future<List<Pesquisa>> getPesquisasOffline() async {
  final secureStorage = SecureStorageService();
  
  String? user = await secureStorage.read("user_data");

  if(user != null){
    Map<String, dynamic> userData = jsonDecode(user);
    List<dynamic>? pesquisasJson = userData['pesquisas'];
  
    if (pesquisasJson != null) {
      List<Pesquisa> pesquisas = pesquisasJson.map((json) => Pesquisa.fromJson(json as Map<String, dynamic>))
      .toList();
      return pesquisas;
    }
  }

  return [];
}
