import 'package:flutter/material.dart';

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
          children: [
            TextFormField(
              autofocus: true,
              controller: cpfController,
              decoration: const InputDecoration(
                
              ),
            ),
            TextFormField(),
            ElevatedButton(onPressed: () {}, child: const Text('ENTRAR')),
            TextButton(onPressed: () {}, child: const Text('Esqueceu sua senha?')),
            TextButton(onPressed: () {}, child: const Text('Registre-se')),
          ],
        ),
      ),
    );
  }
}