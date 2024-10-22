import 'package:flutter/material.dart';
import 'package:inventur/pages/controllers/user_controller.dart';
import 'package:inventur/pages/widgets/registration_form_widget.dart';

class AccountPage extends StatefulWidget {
  final UserController userControllerNotifier;
  
  const AccountPage({super.key, required this.userControllerNotifier});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = widget.userControllerNotifier;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text('Meus Dados'),
        foregroundColor: const Color.fromARGB(255, 55, 111, 60),
        backgroundColor: Colors.white,
        leading: IconButton(
          tooltip: 'Voltar',
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              Colors.green[100]
            )
          ),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 9, 145, 20),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ResgistrationForm(
                      userLevel: _userController.secondaryLevel,
                      userController: _userController,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}