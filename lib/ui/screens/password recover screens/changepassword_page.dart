import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/ui/screens/password%20recover%20screens/changepasswordsucess_page.dart';
import 'package:inventur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MudarSenha extends StatefulWidget {
  MudarSenha({super.key, required this.email});
  final String email;
  @override
  State<MudarSenha> createState() => _MudarSenhaState();
}

class _MudarSenhaState extends State<MudarSenha> {
  final _formLoginKey = GlobalKey<FormState>();

  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    Future<void> requestOtp(String password) async {
      String email = widget.email;
      try {
        final response = await http.post(
          Uri.parse('${AppConstants.BASE_URI}password-reset/change-password/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'new_password': password}),
        );

        if (response.statusCode == 200) {
          print(response.body);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return ConfirmacaoNovaSenha();
          }));
        } else {
          print(response.body);
        }
      } catch (e) {}
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: screenSize.height * 0.35,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Container(
                      child: Form(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                        Form(
                            key: _formLoginKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: screenSize.height * 0.02),
                                PasswordTextField(
                                  isSecret: true,
                                  labelText: 'Nova senha',
                                  controller: _passwordController,
                                  prefixIcon: Icons.lock,
                                  validator: (password) {
                                    if (password == null) {
                                      return 'Preencha o campo!';
                                    }
                                    return _passwordValidator.validate(
                                        password: password);
                                  },
                                ),
                                SizedBox(height: screenSize.height * 0.02),
                                PasswordTextField(
                                  isSecret: true,
                                  labelText: 'Confirmar senha',
                                  controller: _passwordController2,
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Insira uma senha válida';
                                    } else if (_passwordController.text !=
                                        _passwordController2.text) {
                                      return 'As senhas precisam ser iguais!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: screenSize.height * 0.02),
                              ],
                            )),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 55, 111, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              if (_formLoginKey.currentState?.validate() ??
                                  false) {
                                setState(
                                  () => _isLoading = true,
                                );

                                if (_passwordController.text ==
                                    _passwordController2.text) {
                                  requestOtp(_passwordController2.text);
                                  if (mounted) {
                                    setState(
                                      () => _isLoading = false,
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'As senhas não coincidem!')));
                                }
                              }
                            },
                            child: _isLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeAlign: 2,
                                    ),
                                  )
                                : const Text(
                                    'CONFIRMAR',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        SizedBox(
                            height: 50,
                            width: 300,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () => {
                                      Navigator.pop(context, '/PassWordRecover')
                                    },
                                child: const Text(
                                  'CANCELAR',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                )))
                      ]))))
            ])));
  }
}
