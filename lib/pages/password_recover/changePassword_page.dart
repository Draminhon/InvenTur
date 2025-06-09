import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/password_recover/changepassword_page.dart';
import 'package:inventur/pages/password_recover/passwordrecover_page.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:inventur/pages/widgets/text_field_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key, required this.email});
  final String email;
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   

    Future<void> requestOtp(String otp) async {
      String email = widget.email;
      try {
        final response = await http.post(
          Uri.parse('${AppConstants.BASE_URI}password-reset/verify-otp/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'otp': otp}),
        );

        if (response.statusCode == 200) {
              print(response.body);
             Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MudarSenha(email: email,);
          }));

        } else {
                    final snackBar = SnackBar(
            content: Text('Verifique o código informado e tente novamente.'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 3),
          );
            print(response.body);

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {}
    }

    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ Padding(
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
             
                          decoration: BoxDecoration(
                              color:  Color.fromARGB(255, 238, 238, 238),
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
                                      'Para garantir a segurança da sua conta, enviaremos um código de 6 dígitos para o e-mail informado. Por favor, insira o código no aplicativo. O código tem validade de 15 minutos.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: sizeScreen.height * 0.02,
                                  ),
                                ),
                              )
                            ],
                          )))),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formLoginKey,
                child: CustomTextField(
                  labelText: 'Informe o código',
                  controller: _otpController,
                  prefixIcon: Icons.lock,
                  
                ),
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.13),
            SizedBox(
              height: 55,
              width: 350,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  _formLoginKey.currentState!.save();
                    await requestOtp(_otpController.text);
                },
                child: const Text(
                  'CONFIRMAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.02),
            SizedBox(
              height: 55,
              width: 350,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
