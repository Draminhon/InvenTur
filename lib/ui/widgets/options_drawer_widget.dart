import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sistur/controllers/user_controller.dart';
import 'package:sistur/ui/home/Pesquisador/perfil_pesquisador.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'dart:convert';
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

    final secureStorage = SecureStorageService();
    String? refreshToken = await secureStorage.read('refresh_token');

    try {
      if (refreshToken != null) {
        await ApiService().post(
          'logout/',
          data: {'refresh': refreshToken},
        );
      }
    } catch (e) {
      print('Erro ao fazer logout no servidor: $e');
    } finally {
      await secureStorage.clearAll();
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacementNamed(context, '/Login');
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
                  backgroundColor: Colors.white,
                  backgroundImage: user.fotoPerfilBase64 != null
                      ? MemoryImage(base64Decode(user.fotoPerfilBase64!))
                      : (user.fotoPerfil != null
                          ? NetworkImage(user.fullFotoPerfilUrl!)
                          : null) as ImageProvider?,
                  child: (user.fotoPerfil == null && user.fotoPerfilBase64 == null)
                      ? const Icon(
                          Icons.admin_panel_settings,
                          size: 45,
                          color: Color.fromARGB(255, 55, 111, 60),
                        )
                      : null,
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
