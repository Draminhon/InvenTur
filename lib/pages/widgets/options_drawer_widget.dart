import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/home/Administrador/account_page.dart';
import 'package:inventur/pages/controllers/user_controller.dart';
import 'package:inventur/pages/home/Pesquisador/perfil_pesquisador.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class OptionsDrawer extends StatelessWidget {
  final UserController userController;
  final String userName;
  final String userEmail;
  final String cpf;
  const OptionsDrawer({super.key, required this.userController, required this.userName, required this.userEmail, required this.cpf});


Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
String? refreshToken = prefs.getString('refresh_token');
  final response = await http.post(
    Uri.parse('${AppConstants.BASE_URI}/api/v1/logout/'),
    headers: {
      'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',

      },
      
     body: jsonEncode({'refresh': refreshToken}),
  );

  print(response.statusCode);
  if(response.statusCode == 205){
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/Login');
  }else{
    print('Erro ao fazer logout: ${response.body}');
  }
}
  

  @override
  Widget build(BuildContext context) {
    print(userName);
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      child: Column(
        children: [
           UserAccountsDrawerHeader(
            accountName: Text(userName), 
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.admin_panel_settings,
                size: 65,
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )
              ),
              foregroundColor: WidgetStatePropertyAll(Colors.green[800]),
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ContaPesquisador(userName: userName, userEmail: userEmail, userCPF: cpf,)
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.solidUser),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        "Meus Dados",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
          Expanded(child: Container()),
          Divider(
            height: 0,
            thickness: .5,
            color: Colors.grey[900]
          ),
          TextButton(
            style: ButtonStyle(
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )
              ),
              foregroundColor: const WidgetStatePropertyAll(Colors.red),
              overlayColor: WidgetStatePropertyAll(Colors.red[100])
            ),
            onPressed: () async {
              logout(context);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "Sair",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}