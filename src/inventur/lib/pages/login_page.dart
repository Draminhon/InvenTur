import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/common/input_text_decoration.dart';
import 'package:inventur/common/prefix_icon_text.dart';
import 'package:inventur/pages/register_page.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/password_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final _form = GlobalKey<FormState>();
  final CPFValidator _cpfValidator = CPFValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
          top: sizeScreen.height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: const AssetImage('assets/images/logo.png'),
              height: sizeScreen.height * 0.35
            ),
            SizedBox(height: sizeScreen.height * 0.03),
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cpfController,
                    textAlign: TextAlign.center,
                    cursorColor: const Color.fromARGB(255, 9, 145, 20),
                    style: TextStyle(fontSize: sizeScreen.height * 0.028),
                    decoration: textDecoration(
                      hintText: 'CPF',
                      prefixIcon: prefixIcon(FontAwesomeIcons.solidAddressCard, sizeScreen),
                      suffix: SizedBox(
                        width: sizeScreen.width * 0.114, 
                        height: sizeScreen.height * 0.042
                      ),
                      sizeScreen: sizeScreen
                    ),
                    validator: (cpf) {
                      return _cpfValidator.validate(cpf: _cpfController.text);
                    },
                  ),
                  SizedBox(height: sizeScreen.height * 0.03),
                  TextFormField(
                    obscuringCharacter: '●',
                    textAlign: TextAlign.center,
                    controller: _passwordController,
                    cursorColor: const Color.fromARGB(255, 9, 145, 20),
                    style: TextStyle(fontSize: sizeScreen.height * 0.028),
                    decoration: textDecoration(
                      hintText: 'Senha',
                      prefixIcon: prefixIcon(Icons.lock, sizeScreen),
                      suffix: SizedBox(
                        width: sizeScreen.width * 0.114,
                        height: sizeScreen.height * 0.08,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          }, 
                          icon: Icon(
                            !_passwordVisible ? Icons.visibility_off : Icons.visibility,
                            color: const Color.fromARGB(255, 55, 111, 60),
                          ),
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                      errorMaxLines: 3,
                      sizeScreen: sizeScreen
                    ),
                    validator: (password) {
                      return _passwordValidator.validate(password: _passwordController.text);
                    },
                    obscureText: !_passwordVisible,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: sizeScreen.height * 0.04, 
                bottom: sizeScreen.height * 0.03
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    debugPrint("OK!!!");
                  }
                }, 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: sizeScreen.height * 0.012
                    )
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 55, 111, 60)
                  ),
                  overlayColor: MaterialStateProperty.all(
                    Colors.green[600]
                  ),
                ),
                child: Text(
                  'ENTRAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sizeScreen.height * 0.028
                  ),
                )
              ),
            ),
            TextButton(
              onPressed: () {}, 
              child: Text(
                'Esqueceu sua senha?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeScreen.height * 0.025
                ),
              )
            ),
            SizedBox(height: sizeScreen.height * 0.0085),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const RegisterPage())
                );
              }, 
              child: Text(
                'Registre-se',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeScreen.height * 0.025
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
