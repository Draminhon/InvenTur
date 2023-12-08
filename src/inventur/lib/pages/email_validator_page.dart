import 'package:flutter/material.dart';
import 'package:inventur/utils/email_verification_code.dart';
import 'package:inventur/validators/email_verification_code_validator.dart';

class EmailValidatorPage extends StatefulWidget {
  final String email;
  const EmailValidatorPage({super.key, required this.email});

  @override
  State<EmailValidatorPage> createState() => _EmailValidatorPageState();
}

class _EmailValidatorPageState extends State<EmailValidatorPage> {
  // int _codeSendLimit = 5;
  // int _codeShippingAmount = 0;
  int _timeRemaining = 1 * 30;
  late String _verificationCode;
  final _formCodeValidator = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final EmailVerificationCode _emailVerificationCode = EmailVerificationCode();
  final EmailVerificationCodeValidator _codeValidator = EmailVerificationCodeValidator();

  @override
  void initState() {
    super.initState();
    _emailVerificationCode.setCodeTimeout(_timeRemaining);
    _emailVerificationCode.addListener(() {
      setState(() {
        _timeRemaining = _emailVerificationCode.timeRemaining;
        if (_timeRemaining == 0) {
          _verificationCode = _emailVerificationCode.generateVerificationCode();
        }
      });
    });
    _verificationCode = _emailVerificationCode.generateVerificationCode();
    _emailVerificationCode.startCodeTimeout();
    debugPrint(_verificationCode);
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
              padding: EdgeInsets.only(
                left: sizeScreen.height * 0.008,
                top: sizeScreen.height * 0.02,
                right: sizeScreen.height * 0.008,
                bottom: sizeScreen.height * 0.008,
              ),
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
                  SizedBox(height: sizeScreen.height *0.02),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Para confirmar sua identidade, digite o código enviado para o seu e-mail ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: sizeScreen.height * 0.02
                      ),
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 128, 0),
                            fontSize: sizeScreen.height * 0.02
                          )
                        ),
                        TextSpan(
                          text: ". Evite sair da tela atual antes da validação ser concluída",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: sizeScreen.height * 0.02
                          ),
                        )
                      ]
                    ),
                  ),
                  SizedBox(height: sizeScreen.height *0.02),
                  Text(
                    "O código é válido durante 15 minutos",
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: sizeScreen.height * 0.02
                    ),
                  )
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Aguarde: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeScreen.height * 0.028
                ),
                children: [
                  TextSpan(
                    text: '${
                      _timeRemaining ~/ 60 < 10
                      ? "0${_timeRemaining ~/ 60}"
                      : _timeRemaining ~/ 60
                      }:${
                      _timeRemaining % 60 < 10
                      ? "0${_timeRemaining % 60}"
                      : _timeRemaining % 60
                    }',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 128, 0),
                      fontSize: sizeScreen.height * 0.028
                    ),
                  ),
                  TextSpan(
                    text: ' antes de enviar um novo código.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeScreen.height * 0.028
                    ),
                  ),
                ]
              )
            ),
            Padding(
              padding: EdgeInsets.only(top:sizeScreen.height * 0.03, bottom: sizeScreen.height * 0.06),
              child: TextButton(
                onPressed: () {
                  if (_emailVerificationCode.timeRemaining == 0 && !_emailVerificationCode.startedTime) {
                    _verificationCode = _emailVerificationCode.generateVerificationCode();
                    _emailVerificationCode.startCodeTimeout();
                  }
                  debugPrint(_verificationCode);
                }, 
                child: const Text("Enviar novo código")
              ),
            ),
            Form(
              key: _formCodeValidator,
              child: TextFormField(
                controller: _codeController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeScreen.height * 0.028
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Código',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: sizeScreen.height * 0.028
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 55, 111, 60)
                    )
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 9, 145, 20)
                    )
                  ),
                  prefixIcon: Icon(
                    Icons.pin,
                    size: sizeScreen.height * 0.045,
                    color: const Color.fromARGB(255, 55, 111, 60),
                  ),
                  suffixIcon: Container(width: 0)
                ),
                validator: (code) {
                  return _codeValidator.validate(expectedCode: _verificationCode, code: code);
                },
              )
            ),
            SizedBox(height: sizeScreen.height * 0.05),
            SizedBox(
              height: sizeScreen.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  if (_formCodeValidator.currentState!.validate()) {

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
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CONFIRMAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.028
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.04),
            SizedBox(
              height: sizeScreen.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
                    const Color.fromARGB(255, 207, 0, 0)
                  ),
                  overlayColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 247, 22, 22)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CANCELAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.028
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}