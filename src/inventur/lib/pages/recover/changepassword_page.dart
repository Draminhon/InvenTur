import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MudarSenha extends StatelessWidget {
  final PasswordValidator _passwordValidator = PasswordValidator();
    final TextEditingController _passwordController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
        final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        body: SingleChildScrollView(
          reverse: true,
           padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          bottom: 5
        ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding:  EdgeInsets.only(
            top: sizeScreen.height * 0.08,
            left: sizeScreen.height *0.02,
            right: sizeScreen.height * 0.02,
            bottom:  sizeScreen.height * 0.04,
          ),
          child: Center(
          child: Container(
              padding: EdgeInsets.only(
                top: sizeScreen.height * 0.02,
                left: sizeScreen.height * 0.02,
                right: sizeScreen.height * 0.02,
                bottom: sizeScreen.height * 0.008,)
                ,
              height: sizeScreen.height * 0.28,
              margin: EdgeInsets.only(
                top: sizeScreen.height * 0.02,
                bottom: sizeScreen.height * 0.02,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15)),
            
                  child: Column(
                children: [
                  Icon(
                    Icons.info,
                    size: sizeScreen.height * 0.08,
                    color: const Color.fromARGB(255, 55, 111, 60),
                  ),
                  SizedBox(height: sizeScreen.height * 0.02),
                   RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                     text:
                      'Para garantir a segurança da sua conta, enviaremos um código de 6 dígitos para o e-mail cadastrado. Por favor, insira o código no aplicativo. O código tem validade de 15 minutos.',
                      style: TextStyle(color: Colors.black,
                        fontSize: sizeScreen.height * 0.02, ),
                    
                  ),)
                ],
              )))),
              SizedBox(height: sizeScreen.height * 0.03,),
              Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Container(
           
            child: Form(child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  CustomTextField(name: 'Senha', validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            }, getValue: (String ) {  },),
                          SizedBox(height: 15),
                            CustomTextField(name: 'Recuperar Senha', validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            }, getValue: (String ) {  },)
              ],
            )),
          ) 
              ),
          SizedBox(height: sizeScreen.height * 0.13,),
           SizedBox(
            height: 50,
            width: 300,
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
          ),
           SizedBox(height: sizeScreen.height * 0.04,),
      SizedBox(
          height: 50,
          width: 300,
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
