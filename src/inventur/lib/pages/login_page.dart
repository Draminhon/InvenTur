import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              padding: EdgeInsets.only(top: 20, bottom: 80),
              child: Image(
                image: AssetImage('assets/images/logo.png')
              ),
            ),
            TextFormField(
              autofocus: true,
              controller: cpfController,
              decoration: const InputDecoration(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CPF',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                prefixIcon: Icon(
                  FontAwesomeIcons.solidAddressCard,
                  size: 32,
                  color: Color.fromARGB(255, 55, 111, 60),
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 22,
                  minWidth: 42
                ),
                contentPadding: EdgeInsets.only(left: 50),
                alignLabelWithHint: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 55, 111, 60)
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 9, 145, 20)
                  )
                )
              ),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                label: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Senha',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 32,
                  color: Color.fromARGB(255, 55, 111, 60),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 42,
                  maxHeight: 15
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
                contentPadding: const EdgeInsets.only(left: 50),
                alignLabelWithHint: true,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 55, 111, 60)
                  )
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 9, 145, 20)
                  )
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 70, bottom: 20),
              child: ElevatedButton(
                onPressed: () {}, 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
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
