import 'package:flutter/material.dart';
import 'package:inventur/pages/password_recover/changePassword_page.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/validators/email_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecuperarSenha extends StatelessWidget {
  final EmailValidator _emailValidator = EmailValidator();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RecuperarSenha({super.key});
  @override
  Widget build(BuildContext context) {
    Future<void> requestOtp(String email) async {
      try {
        final response = await http.post(
          Uri.parse('${AppConstants.BASE_URI}password-reset/request/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}),
        );

        if (response.statusCode == 200) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return ChangePasswordPage(email: _emailController.text);
          }));
        } else {
          print(response.body);
          final snackBar = SnackBar(
            content: Text('Verifique o e-mail informado e tente novamente.'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        print(e);
      }
    }

    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
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
                              color: const Color.fromARGB(255, 238, 238, 238),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Icon(
                                Icons.info,
                                size: sizeScreen.height * 0.08,
                                color: const Color.fromARGB(255, 55, 111, 60),
                              ),
                              SizedBox(height: sizeScreen.height * 0.01),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Problemas para entrar?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: sizeScreen.height * 0.025,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: sizeScreen.height * 0.01,
                              ),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text:
                                          'Insira o email cadastrado e enviaremos um código para alterar sua senha.',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: sizeScreen.height * 0.02)))
                            ],
                          )))),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                        child: TextFormField(
                            controller: _emailController,
                            validator: (value) =>
                                _emailValidator.validate(email: value),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 55, 111, 60),
                              ),
                              labelText: 'E-mail',
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 1.5)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 1.5)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 55, 111, 60),
                                      width: 1.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 55, 111, 60),
                                      width: 2)),
                            ))),
                  )),
              SizedBox(
                height: sizeScreen.height * 0.13,
              ),
              SizedBox(
                height: 55,
                width: 350,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    _formKey.currentState!.save();
                    if (_formKey.currentState?.validate() ?? false) {
                      await requestOtp(_emailController.text);
                    }
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
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              SizedBox(
                  height: 55,
                  width: 350,
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
