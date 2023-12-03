import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/register_page.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/password_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;

  final _formLogin = GlobalKey<FormState>();
  final CPFValidator _cpfValidator = CPFValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          title: Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              fontSize: sizeScreen.height * 0.028,
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
            Padding(
              padding: EdgeInsets.only(
                top: sizeScreen.height * 0.06,
                bottom: sizeScreen.height * 0.04,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                height: sizeScreen.height * 0.27,
              ),
            ),
            Form(
              key: _formLogin,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cpfController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: sizeScreen.height * 0.028),
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: 'CPF',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: sizeScreen.height * 0.028,
                        ),
                        contentPadding: const EdgeInsets.only(top: 10),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 55, 111, 60)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 9, 145, 20),
                        )),
                        prefixIcon: Icon(
                          FontAwesomeIcons.solidAddressCard,
                          size: sizeScreen.height * 0.04,
                          color: const Color.fromARGB(255, 55, 111, 60),
                        ),
                        suffixIcon: Container(width: 0)),
                        validator: (cpf) {
                          return _cpfValidator.validate(cpf: cpf);
                        },
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  TextFormField(
                    obscuringCharacter: '●',
                    textAlign: TextAlign.center,
                    controller: _passwordController,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: sizeScreen.height * 0.028),
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Senha',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: sizeScreen.height * 0.028,
                        ),
                        errorMaxLines: 3,
                        contentPadding: const EdgeInsets.only(top: 10),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 55, 111, 60))),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 9, 145, 20))),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: sizeScreen.height * 0.05,
                          color: const Color.fromARGB(255, 55, 111, 60),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            !_passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: sizeScreen.height * 0.035,
                            color: const Color.fromARGB(255, 55, 111, 60),
                          ),
                          style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory),
                        )),
                    obscureText: !_passwordVisible,
                    validator: (password) {
                      return _passwordValidator.validate(password: password);
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.03),
            SizedBox(
              height: sizeScreen.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  if (_formLogin.currentState!.validate()) {

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
                      'ENTRAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.028
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.03),
            TextButton(
              onPressed: () {}, 
              child: Text(
                'Esqueceu sua senha?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeScreen.height * 0.025
                ),
              )
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const RegisterPage())
                );
              }, 
              child: Text(
                'Registre-se',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeScreen.height * 0.025
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
