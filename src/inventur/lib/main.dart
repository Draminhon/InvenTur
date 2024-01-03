import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventur/pages/auth/login_page.dart';
import 'package:inventur/pages/auth/register_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InvenTur',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
      ),
      home: const LoginPage(),
      routes: {
        '/Login': (_) => const LoginPage(),
        '/Register': (_) => const RegisterPage(),
      },
    );
  }
}
