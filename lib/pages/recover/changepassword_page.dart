import 'package:flutter/material.dart';
import 'package:inventur/validators/password_validator.dart';

class MudarSenha extends StatelessWidget {
  final PasswordValidator _passwordValidator = PasswordValidator();
  final TextEditingController _passwordController = TextEditingController();

  MudarSenha({super.key});
  @override
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
                                textAlign: TextAlign.justify,
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Container(
                    child: Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                                height: sizeScreen.height * 0.07,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                  ),
                                  labelText: 'Nova senha',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 55, 111, 60),
                                          width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 55, 111, 60),
                                          width: 2)),
                                ))),
                                const SizedBox(height: 20,),
                        SizedBox(
                                height: sizeScreen.height * 0.07,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(
                                   Icons.key,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                  ),
                                  labelText: 'Confirmar senha',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 55, 111, 60),
                                          width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 55, 111, 60),
                                          width: 2)),
                                ))),
                      ],
                    )),
                  )),
              SizedBox(
                height: sizeScreen.height * 0.1,
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
                      {Navigator.pushNamed(context, '/NewPassword')},
                  child: const Text(
                    'CONFIRMAR',
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
                      onPressed: () =>
                          {Navigator.pop(context, '/PassWordRecover')},
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
