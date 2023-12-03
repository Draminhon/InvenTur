import 'dart:async';
import 'package:flutter/material.dart';

class EmailValidatorPage extends StatefulWidget {
  const EmailValidatorPage({super.key});

  @override
  State<EmailValidatorPage> createState() => _EmailValidatorPageState();
}

class _EmailValidatorPageState extends State<EmailValidatorPage> {
  int _timeRemaining = 15 * 60;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining--;
      });

      if (_timeRemaining == 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          title: Text(
            'Validação do E-mail',
            style: TextStyle(
              color: Colors.black,
              fontSize: sizeScreen.height * 0.028
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_timeRemaining ~/ 60}:${
                _timeRemaining % 60 < 10
                ? "0${_timeRemaining % 60}"
                : _timeRemaining % 60
              }',
              style: TextStyle(
                color: Colors.black,
                fontSize: sizeScreen.height * 0.028
              ),
            ),
            Row()
          ],
        ),
      ),
    );
  }
}
