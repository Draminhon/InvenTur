import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/widgets/custom_text_field_widget.dart';
import 'package:inventur/pages/widgets/divider_text_widget.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formLoginKey = GlobalKey<FormState>();

  final CPFValidator _cpfValidator = CPFValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');

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
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenSize.height * .07),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: screenSize.height * 0.35,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formLoginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          labelText: 'CPF',
                          controller: _cpfController,
                          keyboardType: TextInputType.number,
                          prefixIcon: FontAwesomeIcons.solidAddressCard,
                          validator: (cpf) {
                            return _cpfValidator.validate(cpf: cpf);
                          },
                          inputFormatters: [cpfMask],
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextField(
                          isSecret: true,
                          labelText: 'Senha',
                          controller: _passwordController, 
                          prefixIcon: Icons.lock,
                          validator: (password) {
                            return _passwordValidator.validate(password: password);
                          },
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        SizedBox(
                          height: screenSize.height * .07,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              padding: MaterialStateProperty.all(
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
                              // if (_formLoginKey.currentState!.validate()) {
                              //   Navigator.pushNamed(context, '/AdminHome');
                              // }
                              Navigator.pushNamed(context, '/AdminHome');
                            }, 
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                              ),
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: screenSize.height * .015),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 55, 111, 60),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color.fromARGB(255, 55, 111, 60),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: DividerText(text: 'Solicite seu Registro')
                        ),
                        SizedBox(
                          height: screenSize.height * .07,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              side: const MaterialStatePropertyAll(
                                BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 55, 111, 60),
                                )
                              ),
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: screenSize.height * .012)
                              )
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Register');
                            }, 
                            child: const Text(
                              'Registre-se',
                              style: TextStyle(
                                fontSize: 22
                              ),
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}