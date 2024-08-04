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

  final _formRegisterKey = GlobalKey<FormState>();

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
        centerTitle: true,
        foregroundColor: const Color.fromARGB(255, 55, 111, 60),
        backgroundColor: Colors.white,
        leading: Container(),
        // leading: IconButton(
        //   tooltip: 'Voltar',
        //   style: ButtonStyle(
        //     overlayColor: WidgetStatePropertyAll(
        //       Colors.green[100]
        //     )
        //   ),
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Color.fromARGB(255, 9, 145, 20),
        //   ),
        // ),
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
                    RegisterForm(
                      userController: _userController,
                      formRegisterKey: _formRegisterKey,
                    ),
                    SizedBox(
                      height: screenSize.height * .07,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(
                              vertical: screenSize.height * .012
                            )
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 55, 111, 60)
                          ),
                          overlayColor: WidgetStateProperty.all(
                            Colors.green[600]
                          )
                        ),
                        onPressed: () {
                          if (_formRegisterKey.currentState!.validate()){}
                        },
                        child: Text(
                          'Salvar Alterações',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.height * .03
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: screenSize.height * .07,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(
                              vertical: screenSize.height * .012
                            )
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 232, 0, 0)
                          ),
                          overlayColor: WidgetStateProperty.all(
                            Colors.red[500]
                          )
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.height * .03
                          ),
                        )
                      ),
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