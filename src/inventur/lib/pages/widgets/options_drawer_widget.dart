import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/home/Administrador/account_page.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';

class OptionsDrawer extends StatelessWidget {
  final UserController userController;

  const OptionsDrawer({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('accountName'), 
            accountEmail: Text('accountEmail'),
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.admin_panel_settings,
                size: 65,
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              shape: const MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )
              ),
              foregroundColor: MaterialStatePropertyAll(Colors.green[800]),
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AccountPage(
                  userControllerNotifier: userController,
                ),
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
              shape: const MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )
              ),
              foregroundColor: const MaterialStatePropertyAll(Colors.red),
              overlayColor: MaterialStatePropertyAll(Colors.red[100])
            ),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
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