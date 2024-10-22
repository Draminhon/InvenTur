import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/widgets/text_field_widget.dart';
import 'package:inventur/pages/widgets/divider_text_widget.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


// Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('acess_token');
// }


Future<void> loginUser(String CPF, String password) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/v1/login');

  try{
    final response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(<String, String>{
       'CPF': CPF,
      'password': password,
    }),
    );
    if(response.statusCode == 200){
      print('Usuario registrado com sucesso');
    }else{
      print('Erro ao registrar o usuário: ${response.body}');    }

     }catch(e){
      print('Erro: $e');
     }
  }


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formLoginKey = GlobalKey<FormState>();

  final CPFValidator _cpfValidator = CPFValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    Future<void> loginUser(String cpf, String password) async {
        final url = Uri.parse('http://10.0.2.2:8000/api/v1/login/');

        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, String>{
              'CPF': cpf,
              'password': password,
          })
        );

        if (response.statusCode == 200){

          // final Map<String, dynamic> responseData = json.decode(response.body);

          // String acessToken = responseData['access'];

          // final prefs = await SharedPreferences.getInstance();
          // await prefs.setString('acess_token', acessToken);

          // print("TOKEN ARMAZENADO:  $acessToken");



          print("Usuario logado com sucesso");
        }else{
          print("Usário nao logado ${response.body}");
        }

    }


    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height - MediaQuery.paddingOf(context).top,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenSize.height * .07),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: screenSize.height * 0.35,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formLoginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          labelText: 'CPF',
                          controller: _cpfController,
                          keyboardType: TextInputType.number,
                          prefixIcon: FontAwesomeIcons.solidAddressCard,
                          validator: (cpf) {
                            return _cpfValidator.validate(cpf: cpf);
                          },
                          inputFormatters: [cpfMask],
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextField(
                          isSecret: true,
                          labelText: 'Senha',
                          controller: _passwordController, 
                          prefixIcon: Icons.lock,
                          // validator: (password) {
                          //   return _passwordValidator.validate(password: password);
                          // },
                        ),
                        SizedBox(height: screenSize.height * 0.02),
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
                                  vertical: screenSize.height * 0.012
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
                              if (_formLoginKey.currentState!.validate()) {

                                      print("AAAAAAAAAAAA");
                                final cpf = _cpfController.text.replaceAll('.','').replaceAll('-', '');
                                final password = _passwordController.text;

                                loginUser(cpf, password);
                                  }
                            //  Navigator.pushNamed(context, '/Choose');
                            }, 
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                              ),
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: screenSize.height * .015),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {Navigator.pushNamed(context, '/PassWordRecover');},
                              child: const Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 55, 111, 60),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color.fromARGB(255, 55, 111, 60),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: DividerText(text: 'Solicite seu Registro')
                        ),
                        SizedBox(
                          height: screenSize.height * .07,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              side: const WidgetStatePropertyAll(
                                BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 55, 111, 60),
                                )
                              ),
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(vertical: screenSize.height * .012)
                              )
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Register');
                            }, 
                            child: const Text(
                              'Registre-se',
                              style: TextStyle(
                                fontSize: 22
                              ),
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}