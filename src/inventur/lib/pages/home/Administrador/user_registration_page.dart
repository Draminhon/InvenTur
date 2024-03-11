import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/home/Administrador/widgets/custom_radio_button_widget.dart';
import 'package:inventur/pages/widgets/registration_form_widget.dart';

class AddUserPage extends StatefulWidget {
  final UserController userControllerNotifier;

  const AddUserPage({super.key, required this.userControllerNotifier});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  String userLevel = 'usuário !?';
  
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = widget.userControllerNotifier;
  }

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: const Color.fromARGB(255, 55, 111, 60),
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            Text(
              'Adicionar um novo $userLevel',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            CustomRadioButton(
              accessLevels: _userController.accessLeves, 
              onChanged: (accessLevel) {
                setState(() {
                  userLevel = 'usuário $accessLevel';
                });
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 40),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(255, 55, 111, 60),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Um e-mail com os dados cadastrados será enviado para o usuário',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            ResgistrationForm()
          ],
        ),
      ),
    );
  }
}