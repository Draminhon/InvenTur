import 'package:flutter/material.dart';
import 'package:inventur/utils/email_verification_code.dart';

class EmailValidatorPage extends StatefulWidget {
  const EmailValidatorPage({super.key});

  @override
  State<EmailValidatorPage> createState() => _EmailValidatorPageState();
}

class _EmailValidatorPageState extends State<EmailValidatorPage> {
  int _timeRemaining = 1 * 60;
  late String _verificationCode;
  final EmailVerificationCode _emailVerificationCode = EmailVerificationCode();

  @override
  void initState() {
    super.initState();
    _emailVerificationCode.addListener(() {
      setState(() {
        _timeRemaining = _emailVerificationCode.timeRemaining;
      });
    });
    _verificationCode = _emailVerificationCode.generateVerificationCode();
    _emailVerificationCode.startCodeTimeout();
  }

  @override
  void dispose() {
    _emailVerificationCode.setStopCodeTimeout(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          title: Text(
            'Validação do e-mail',
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
            Container(
              width: sizeScreen.width * 0.8,
              height: sizeScreen.height * 0.3,
              margin: EdgeInsets.all(sizeScreen.height * 0.02),
              padding: EdgeInsets.all(sizeScreen.height * 0.008),
              decoration: BoxDecoration(
                color: const Color.fromARGB(225, 227, 226, 226),
                borderRadius: BorderRadius.circular(sizeScreen.height * 0.03)
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.info,
                    size: sizeScreen.height * 0.08,
                    color: const Color.fromARGB(255, 0, 128, 0),
                  ),
                  Text(
                    "Para confirmar sua identidade, enviaremos um código para o e-mail. Evite sair da tela atual antes da validação ser concluída",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeScreen.height * 0.028
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "O código é válido durante 15 minutos",
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: sizeScreen.height * 0.028
                    ),
                  )
                ],
              ),
            ),
            Text(
              '${
                _timeRemaining ~/ 60 < 10
                ? "0${_timeRemaining ~/ 60}"
                : _timeRemaining ~/ 60
                }:${
                _timeRemaining % 60 < 10
                ? "0${_timeRemaining % 60}"
                : _timeRemaining % 60
              }',
              style: TextStyle(
                color: Colors.black,
                fontSize: sizeScreen.height * 0.028
              ),
            ),
            TextButton(
              onPressed: () {
                if (_emailVerificationCode.timeRemaining == 0) {
                  _verificationCode = _emailVerificationCode.generateVerificationCode();
                  _emailVerificationCode.startCodeTimeout();
                }
              }, 
              child: Text("Enviar novo código")
            ),
            Row()
          ],
        ),
      ),
    );
  }
}