import 'package:flutter/material.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/pages/widgets/custom_text_field_widget.dart';
import 'package:inventur/pages/auth/email_validator_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class RecuperarSenha extends StatelessWidget {
  final EmailValidator _emailValidator = EmailValidator();
   final TextEditingController _emailController = TextEditingController();
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
                  color: Colors.grey[200],
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
          padding: EdgeInsets.all(25),
          child: CustomTextField(
                            labelText: 'E-mail',
                            controller: _emailController,
                            prefixIcon: FontAwesomeIcons.solidEnvelope,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              return _emailValidator.validate(email: email);
                            },
                          ),),
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
               
                     Navigator.pushNamed(context, '/ConfirmarCodigo')
              },
              child: const Text(
                'OBTER CÓDIGO',
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
              onPressed: () => {Navigator.pop(context)},
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
