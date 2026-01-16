import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/ui/screens/password%20recover%20screens/changepassword_page.dart';
import 'package:inventur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:inventur/utils/app_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PasswordotpPage extends StatefulWidget {
  PasswordotpPage({super.key, required this.email});
  final String email;
  @override
  State<PasswordotpPage> createState() => _PasswordotpPageState();
}

class _PasswordotpPageState extends State<PasswordotpPage> {
  final _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
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
  @override
  Widget build(BuildContext context) {
   



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
                child: PasswordTextField(
                  labelText: 'Informe o código',
                  controller: _otpController,
                  prefixIcon: Icons.lock,
                  
                ),
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.13),
            SizedBox(
              height: 55,
              width: 1200.w,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  
                  _formLoginKey.currentState!.save();
                                        setState(() => _isLoading = true,);

                    await requestOtp(_otpController.text);
                      if(mounted){
                        setState(() => _isLoading=false,);
                      }
                },
                child:  _isLoading ?
                  SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(color: Colors.white, strokeAlign: 2,),
                  ) :
                   const Text(
                    'CONFIRMAR',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.02),
            SizedBox(
              height: 55,
              width: 1200.w,
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