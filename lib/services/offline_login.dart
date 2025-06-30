import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventur/main.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/pages/home/Administrador/admin_home_page.dart';
import 'package:inventur/pages/home/Pesquisador/pesquisador_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initApp() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString("access_token") != null) {

    String token = prefs.getString("access_token")!;
    String? user = prefs.getString("user_data")!;

    Map<String, dynamic> userData = jsonDecode(user);
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
        builder: (context) => userData['access_level'] == 'Pesquisador'
            ? const PesquisadorHome()
            : const AdminHomePage()));
  } 
}

Future<List<Pesquisa>> getPesquisasOffline() async {
  final prefs = await SharedPreferences.getInstance();
  
   String? user = prefs.getString("user_data")!;

    Map<String, dynamic> userData = jsonDecode(user);

    List<dynamic> pesquisasJson = userData['pesquisas'];
    
    List<Pesquisa> pesquisas =pesquisasJson.map((json) => Pesquisa.fromJson(json as Map<String, dynamic>))
    .toList();

    return pesquisas;
}
