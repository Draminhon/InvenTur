import 'package:flutter/material.dart';
import 'package:sistur/controllers/user_controller.dart';
import 'package:sistur/ui/widgets/forms/registration_form_widget.dart';

class AdminRegisterDialogButton extends StatelessWidget {
  final UserController userControllerNotifier;

  const AdminRegisterDialogButton({super.key, required this.userControllerNotifier});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 0, horizontal: 10)
        ),
        visualDensity: VisualDensity.compact,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        side: const WidgetStatePropertyAll(
          BorderSide(
            color: Color.fromARGB(255, 55, 111, 60),
            width: 2,
          )
        ),
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_add_alt_1_rounded,
            color: Color.fromARGB(255, 55, 111, 60),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text('Cadastrar pesquisador', maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
      onPressed: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => RegisterAdminDialog(
          userControllerNotifier: userControllerNotifier,
        ),
      ),
    );
  }
}

class RegisterAdminDialog extends StatefulWidget {
  final UserController userControllerNotifier;
  
  const RegisterAdminDialog({super.key, required this.userControllerNotifier});

  @override
  State<RegisterAdminDialog> createState() => _RegisterAdminDialogState();
}

class _RegisterAdminDialogState extends State<RegisterAdminDialog> with SingleTickerProviderStateMixin {
  late UserController _userController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
    
    _userController = widget.userControllerNotifier;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
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
                    Row(
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.comfortable,
                          onPressed: () {
                            _animationController.reverse();
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.red[700]),
                            shadowColor: const WidgetStatePropertyAll(Colors.white),
                            overlayColor: WidgetStatePropertyAll(Colors.red[500]),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap
                          ),
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'Cadastrar novo pesquisador',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: screenSize.height * .02,
                        bottom: screenSize.height * .02,
                      ),
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
                          // Text(
                          //   'Um e-mail com os dados cadastrados será enviado para o usuário',
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     fontSize: screenSize.height * .022,
                          //   ),
                          // ),
                          Text(
                            'O pesquisador poderá registrar formulários nas pesquisas às quais for vinculado '
                            '(pelo código da pesquisa). Administradores criam a própria conta no cadastro do aplicativo.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: screenSize.height * .02,
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
    );
  }
}