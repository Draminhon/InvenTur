import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/common/input_text_decoration.dart';
import 'package:inventur/common/prefix_icon_text.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/password_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final CPFValidator _cpfValidator = CPFValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: Image(
                image: const AssetImage('assets/images/logo.png'),
                height: MediaQuery.of(context).size.height * 0.39
              ),
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cpfController,
                    textAlign: TextAlign.center,
                    cursorColor: const Color.fromARGB(255, 9, 145, 20),
                    style: const TextStyle(fontSize: 20),
                    decoration: InputTextDecoration.textDecoration.copyWith(
                      hintText: 'CPF',
                      prefixIcon: prefixIcon(FontAwesomeIcons.solidAddressCard),
                      suffix: const SizedBox(width: 41, height: 35)
                    ),
                    validator: (cpf) {
                      return _cpfValidator.validate(cpf: _cpfController.text);
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    obscuringCharacter: '●',
                    textAlign: TextAlign.center,
                    controller: _passwordController,
                    cursorColor: const Color.fromARGB(255, 9, 145, 20),
                    style: const TextStyle(fontSize: 20),
                    decoration: InputTextDecoration.textDecoration.copyWith(
                      hintText: 'Senha',
                      prefixIcon: prefixIcon(Icons.lock),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        }, 
                        icon: Icon(
                          !_passwordVisible ? Icons.visibility_off : Icons.visibility,
                          size: 25,
                          color: const Color.fromARGB(255, 55, 111, 60),
                        ),
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          iconSize: MaterialStatePropertyAll(20),
                          splashFactory: NoSplash.splashFactory
                        ),
                      ),
                      errorMaxLines: 3
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
              margin: const EdgeInsets.only(top: 60, bottom: 20),
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
                    const EdgeInsets.symmetric(
                      vertical: 12
                    )
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 55, 111, 60)
                  ),
                  overlayColor: MaterialStateProperty.all(
                    Colors.green[600]
                  ),
                ),
                child: const Text(
                  'ENTRAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                )
              ),
            ),
            TextButton(
              onPressed: () {}, 
              child: const Text(
                'Esqueceu sua senha?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              )
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {}, 
              child: const Text(
                'Registre-se',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
