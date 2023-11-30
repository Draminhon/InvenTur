import 'package:flutter/material.dart';
import 'package:inventur/common/single_child_scroll_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formRegister = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: scrollView(
        sizeScreen: sizeScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Form(
                key: _formRegister,
                child: Column(
                  children: [
                    TextFormField(),
                  ],
                )
              ),
            ),
            SizedBox(
              height: sizeScreen.height * 0.08,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("REGISTRAR"),
              ),
            )
          ],
        )
      ),
    );
  }
}
