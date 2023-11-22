import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/common/input_text_decoration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 70),
              child: Image(
                image: AssetImage('assets/images/logo.png')
              ),
            ),
            TextFormField(
              controller: cpfController,
              textAlign: TextAlign.center,
              cursorColor: const Color.fromARGB(255, 9, 145, 20),
              style: const TextStyle(fontSize: 20),
              decoration: InputTextDecoration.textDecoration.copyWith(
                hintText: 'CPF',
                prefixIcon: const Icon(
                  FontAwesomeIcons.solidAddressCard,
                  size: 32,
                  color: Color.fromARGB(255, 55, 111, 60),
                ),
                suffix: Container(width: 40),
              )
            ),
            const SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              obscuringCharacter: '●',
              textAlign: TextAlign.center,
              controller: passwordController,
              cursorColor: const Color.fromARGB(255, 9, 145, 20),
              style: const TextStyle(fontSize: 20),
              decoration: InputTextDecoration.textDecoration.copyWith(
                hintText: 'Senha',
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 32,
                  color: Color.fromARGB(255, 55, 111, 60),
                ),
                suffix: IconButton(
                  onPressed: () {}, 
                  icon: const Icon(
                    FontAwesomeIcons.eyeSlash,
                    color: Color.fromARGB(255, 55, 111, 60),
                  ),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    iconSize: MaterialStatePropertyAll(20),
                    splashFactory: NoSplash.splashFactory
                  ),
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 20),
              child: ElevatedButton(
                onPressed: () {}, 
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
