import 'package:flutter/material.dart';
import 'package:inventur/validators/email_validator.dart';


class RecuperarSenha extends StatelessWidget {
  final EmailValidator _emailValidator = EmailValidator();
  final TextEditingController _emailController = TextEditingController();

  RecuperarSenha({super.key});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        body: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                  padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.08,
                    left: sizeScreen.height * 0.02,
                    right: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.04,
                  ),
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.only(
                            top: sizeScreen.height * 0.02,
                            left: sizeScreen.height * 0.02,
                            right: sizeScreen.height * 0.02,
                            bottom: sizeScreen.height * 0.008,
                          ),
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
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text:
                                      'Para garantir a segurança da sua conta, enviaremos um código de 6 dígitos para o e-mail cadastrado. Por favor, insira o código no aplicativo. O código tem validade de 15 minutos.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: sizeScreen.height * 0.02,
                                  ),
                                ),
                              )
                            ],
                          )))),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: SizedBox(
                    height: sizeScreen.height * 0.07,
                    child: TextFormField(
  decoration: InputDecoration(
    fillColor: Colors.white,
    filled: true,
    prefixIcon: const Icon(
      Icons.email,
      color: Color.fromARGB(255, 55, 111, 60),
    ),
    labelText: 'E-mail',
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60), width: 2)
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60), width: 2)
    ),
                  )))),
              SizedBox(
                height: sizeScreen.height * 0.13,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () =>
                      {Navigator.pushNamed(context, '/ConfirmarCodigo')},
                  child: const Text(
                    'OBTER CÓDIGO',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),
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
