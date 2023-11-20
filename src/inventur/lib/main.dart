import 'package:flutter/material.dart';
import 'package:inventur/pages/login_page.dart';

void main() {
  runApp(const MyAppPage());
}

class MyAppPage extends StatelessWidget {
  const MyAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InvenTur',
      home: LoginPage(),
    );
  }
}