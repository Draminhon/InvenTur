import 'package:flutter/material.dart';
import 'package:inventur/pages/auth/register_page.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/widgets/custom_text_field.dart';

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
                  CustomTextField(
                    hintText: 'CPF',
                    prefixIconSize: 0.035,
                    sizeScreen: sizeScreen,
                    controller: _cpfController,
                    suffixIcon: Container(width: 0),
                    prefixIcon: FontAwesomeIcons.solidAddressCard,
                    validator: (cpf) {
                      return _cpfValidator.validate(cpf: cpf);
                    },
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  CustomTextField(
                    hintText: 'Senha',
                    prefixIconSize: 0.045,
                    sizeScreen: sizeScreen,
                    prefixIcon: Icons.lock,
                    controller: _passwordController,
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
                        splashFactory: NoSplash.splashFactory
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    validator: (password) {
                      return _passwordValidator.validate(password: password);
                    },
                  ),
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
            SizedBox(height: sizeScreen.height * 0.01),
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
