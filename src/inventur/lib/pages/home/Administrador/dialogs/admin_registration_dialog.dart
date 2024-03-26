import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/widgets/registration_form_widget.dart';

class AddAdminDialog extends StatefulWidget {
  final UserController userControllerNotifier;

  const AddAdminDialog({super.key, required this.userControllerNotifier});

  @override
  State<AddAdminDialog> createState() => _AddAdminDialogState();
}

class _AddAdminDialogState extends State<AddAdminDialog> {
  
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = widget.userControllerNotifier;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return OutlinedButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 0, horizontal: 10)
        ),
        visualDensity: VisualDensity.compact,
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        side: const MaterialStatePropertyAll(
          BorderSide(
            color: Color.fromARGB(255, 55, 111, 60),
            width: 2,
          )
        ),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        foregroundColor: const MaterialStatePropertyAll(Colors.black),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap
      ),
      child: const Row(
        children: [
          Icon(
            Icons.add_moderator_rounded,
            color: Color.fromARGB(255, 55, 111, 60),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text('Add administrador'),
          )
        ],
      ),
      onPressed: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red[700]),
                      shadowColor: const MaterialStatePropertyAll(Colors.white),
                      overlayColor: MaterialStatePropertyAll(Colors.red[500])
                    ),
                    icon: const Icon(
                      Icons.close,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
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
                      const Text(
                        'Adicionar um novo Administrador',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 40),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(225, 227, 226, 226),
                          borderRadius: BorderRadius.circular(screenSize.height * .03)
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: screenSize.height * .08,
                              color: const Color.fromARGB(255, 55, 111, 60),
                            ),
                            SizedBox(height: screenSize.height * .02),
                            const Text(
                              'Um e-mail com os dados cadastrados será enviado para o usuário',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'O usuário terá acesso à todas as funcionalidades disponíveis ao perfil de nivel Administrador',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.orange[900],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ResgistrationForm(
                        userLevel: _userController.primaryLevel,
                        userController: _userController,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}