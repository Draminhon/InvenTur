import 'package:flutter/material.dart';
import 'package:inventur/pages/widgets/custom_text_field_widget.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MudarSenha extends StatelessWidget {
  final PasswordValidator _passwordValidator = PasswordValidator();
    final TextEditingController _passwordController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.all(45),
          child: Center(
          child: Container(
              padding: const EdgeInsets.all(20),
              height: sizeScreen.height * 0.3,
              width: sizeScreen.width ,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)),
              child: Expanded(
                  child: Column(
                children: [
                  Image.asset(
                    'assets/images/novo.png',
                    height: sizeScreen.height * 0.05,
                    width: sizeScreen.width,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Para garantir a segurança da sua conta, enviaremos um código de 6 dígitos para o e-mail cadastrado. Por favor, insira o código no aplicativo. O código tem validade de 15 minutos.',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ))))),
              Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Container(
            padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
            child: Form(child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  CustomTextField(
                            labelText: 'Senha',
                            prefixIcon: Icons.lock, 
                            controller: _passwordController, 
                            isSecret: true,
                            validator: (password) {
                              return _passwordValidator.validate(password: password);
                            }, 
                          ),
                          SizedBox(height: 15),
                            CustomTextField(
                            labelText: 'Recuperar senha',
                            prefixIcon: Icons.lock, 
                            controller: _passwordController, 
                            isSecret: true,
                            validator: (password) {
                              return _passwordValidator.validate(password: password);
                            }, 
                          ),
              ],
            )),
          ) 
              ),
               Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 120),
          child: SizedBox(
            height: 50,
            width: 250,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => {
                Navigator.pushNamed(context, '/NewPassword')
              },
              child: const Text(
                'CONFIRMAR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ),
          )),
          
      SizedBox(
          height: 50,
          width: 250,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => {Navigator.pop(context, '/PassWordRecover')},
              child: const Text(
                'CANCELAR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              )))
    ])));
  }
}
