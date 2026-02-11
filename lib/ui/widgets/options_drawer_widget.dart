import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sistur/controllers/user_controller.dart';
import 'package:sistur/ui/home/Pesquisador/perfil_pesquisador.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sistur/providers/providers.dart';

class OptionsDrawer extends StatefulWidget {
  final UserController userController;
  
  const OptionsDrawer({super.key, required this.userController});

  @override
  State<OptionsDrawer> createState() => _OptionsDrawerState();
}

class _OptionsDrawerState extends State<OptionsDrawer> {


  bool _isLoading = false;


Future<void> logout(BuildContext context) async {


  setState(() {
    _isLoading = true;
  });


  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
String? refreshToken = prefs.getString('refresh_token');
try{final response = await http.post(
    Uri.parse('${AppConstants.BASE_URI}logout/'),
    headers: {
      'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',

      },
      
     body: jsonEncode({'refresh': refreshToken}),
  );

  print(response.statusCode);
  if(response.statusCode == 205){
   
     await prefs.remove('access_token');
  await prefs.remove('user_data');
    Navigator.pushReplacementNamed(context, '/Login');
    
  }else{
    print('Erro ao fazer logout: ${response.body}');
        await prefs.remove('access_token');
    await prefs.remove('user_data');
    Navigator.pushReplacementNamed(context, '/Login');
  }}catch(e){
    await prefs.remove('access_token');
    await prefs.remove('user_data');
    Navigator.pushReplacementNamed(context, '/Login');
    
  }finally{
    setState(() {
      _isLoading = false;
    });
  }
  
}

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        return Drawer(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          child: Column(
            children: [
               UserAccountsDrawerHeader(
                accountName: Text(user.username), 
                accountEmail: Text(user.email),
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
                    builder: (context) => const ContaPesquisador()
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
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  _isLoading?SizedBox():  Icon(Icons.logout_rounded),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: _isLoading == false? Text(
                        "Sair",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ) : CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      }
    );
  }
}
