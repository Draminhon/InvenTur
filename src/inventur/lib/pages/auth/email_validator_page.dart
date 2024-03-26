import 'package:flutter/material.dart';
import 'package:inventur/pages/widgets/text_field_widget.dart';
import 'package:inventur/services/email_verification_code.dart';
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

  final _formCodeValidator = GlobalKey();
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
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height - MediaQuery.paddingOf(context).top,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: screenSize.height * .02),
                        padding: EdgeInsets.all(screenSize.height * .008),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(225, 227, 226, 226),
                          borderRadius: BorderRadius.circular(screenSize.height * .03)
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: screenSize.height * .08,
                              color: const Color.fromARGB(255, 55, 111, 60),
                            ),
                            SizedBox(height: screenSize.height * .02),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Validação do E-mail\n\n",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.height * .023
                                ),
                                children: [
                                  TextSpan(
                                    text: "Para confirmar sua identidade, digite o código enviado para o e-mail ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSize.height * .02
                                    )
                                  ),
                                  TextSpan(
                                    text: widget.email,
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 128, 0),
                                      fontSize: screenSize.height * .02
                                    )
                                  ),
                                ]
                              ),
                            ),
                            SizedBox(height: screenSize.height *.02),
                            Text(
                              "O código é válido durante 15 minutos",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 207, 0, 0),
                                fontSize: screenSize.height * .02
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
                            fontSize: screenSize.height * .028
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
                                fontSize: screenSize.height * .028
                              ),
                            ),
                            TextSpan(
                              text: ' antes de enviar um novo código.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenSize.height * .028
                              ),
                            ),
                          ]
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenSize.height * .03),
                        child: TextButton(
                          onPressed: () {
                            if (_emailVerificationCode.timeRemaining == 0 && !_emailVerificationCode.startedTime) {
                              _verificationCode = _emailVerificationCode.generateVerificationCode();
                              _emailVerificationCode.startCodeTimeout();
                            }
                            debugPrint(_verificationCode);
                          },
                          child: Text(
                            "Enviar novo código",
                            style: TextStyle(
                              fontSize: screenSize.height * .02
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Insira o código de 6 dígitos',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 128, 0),
                                fontSize: screenSize.height * .021,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _formCodeValidator,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              labelText: 'Código',
                              prefixIcon: Icons.pin,
                              controller: _codeController,
                              validator: (code) {
                                return _codeValidator.validate(expectedCode: _verificationCode, code: code);
                              },
                            ),
                            SizedBox(height: screenSize.height * .015),
                            SizedBox(
                              height: screenSize.height * .07,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                      vertical: screenSize.height * 0.012
                                    )
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 55, 111, 60)
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.green[600]
                                  )
                                ),
                                onPressed: () {
                                  
                                },
                                child: const Text(
                                  'Confirmar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenSize.height * .015),
                            SizedBox(
                              height: screenSize.height * .07,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                  side: MaterialStatePropertyAll(
                                    BorderSide(
                                      width: 2,
                                      color: Colors.red[700]!
                                    )
                                  ),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                      vertical: screenSize.height * 0.012
                                    )
                                  ),
                                  overlayColor: MaterialStatePropertyAll(
                                    Colors.red[100]
                                  )
                                ),
                                onPressed: () {
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                },
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 22
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}