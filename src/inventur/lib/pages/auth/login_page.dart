import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/password_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = true;

  final _formLoginKey = GlobalKey<FormState>();
  final CPFValidator _cpfValidator = CPFValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          width: sizeScreen.width,
          height: sizeScreen.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: sizeScreen.height * 0.35,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 30,
                ),
                child: Form(
                  key: _formLoginKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _cpfController,
                        decoration: InputDecoration(
                          labelText: 'CPF',
                          isDense: true,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.solidAddressCard,
                            color: Color.fromARGB(255, 55, 111, 60)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                          )
                        ),
                        validator: (cpf) {
                          return _cpfValidator.validate(cpf: cpf);
                        },
                      ),
                      SizedBox(height: sizeScreen.height * 0.02),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _passwordVisible,
                        obscuringCharacter: '●',
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          isDense: true,
                          errorMaxLines: 3,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color:Color.fromARGB(255, 55, 111, 60)
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            }, 
                            icon: Icon(
                              _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                              color: const Color.fromARGB(255, 55, 111, 60)
                            )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                          )
                        ),
                        validator: (password) {
                          return _passwordValidator.validate(password: password);
                        },
                      ),
                      SizedBox(height: sizeScreen.height * 0.02),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
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
                          onPressed: () {
                            if (_formLoginKey.currentState!.validate()) {
                              Navigator.pushNamed(context, '/AdminHome');
                            }
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
                      Align(
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(255, 9, 145, 20),
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Solicite seu Registro',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 9, 145, 20)
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(255, 9, 145, 20),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 55, 111, 60)
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
    );
  }
}