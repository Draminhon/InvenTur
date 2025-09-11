import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Certifique-se de que os imports das suas páginas e do navigatorKey estão corretos.
import 'package:inventur/main.dart';
import 'package:inventur/pages/auth/login_page.dart';
import 'package:inventur/pages/home/Pesquisador/pesquisador_homepage.dart';
import 'package:inventur/pages/home/Administrador/admin_home_page.dart';


Future<void> initApp() async {
  try {
    final prefs = await SharedPreferences.getInstance();

    // 1. Obtenha os dados de forma segura, sem usar o operador '!'
    // Isso evita erros caso a chave não exista.
    final String? token = prefs.getString("access_token");
    final String? userDataString = prefs.getString("user_data");

    // 2. Valide se os dados essenciais realmente existem
    // Se o token ou os dados do usuário forem nulos ou vazios, a sessão é inválida.
    if (token == null || token.isEmpty || userDataString == null || userDataString.isEmpty) {
      // Interrompe a função aqui. O app irá naturalmente para a LoginPage.
      return;
    }

    // 3. Decodifique o JSON e acesse os dados de forma segura
    final userData = jsonDecode(userDataString) as Map<String, dynamic>;
    final String? accessLevel = userData['access_level']; // Pega o nível de acesso como uma string que pode ser nula

    Widget destinationPage;

    // Use um 'switch' para um roteamento mais claro e escalável
    switch (accessLevel) {
      case 'Pesquisador':
        destinationPage = const PesquisadorHome();
        break;
 
      default:
        // Se o 'access_level' for nulo, inválido ou desconhecido,
        // o usuário é enviado para a tela de login por segurança.
        destinationPage = LoginPage();
        break;
    }
    
    // Navega para a página de destino substituindo a tela atual
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => destinationPage),
    );

  } catch (e) {
    // 4. Captura qualquer erro inesperado (ex: JSON malformado)
    // Se algo der errado, consideramos a sessão inválida.
    debugPrint("Falha ao restaurar a sessão do usuário: $e");
    // O app não fará nada e continuará para a tela de Login.
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