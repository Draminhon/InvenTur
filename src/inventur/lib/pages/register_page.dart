import 'package:flutter/material.dart';
import 'package:inventur/pages/email_validator_page.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/name_validator.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/validators/password_confirm_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  final _formRegister = GlobalKey<FormState>();
  final CPFValidator _cpfValidator = CPFValidator();
  final NameValidator _nameValidator = NameValidator();
  final EmailValidator _emailValidator = EmailValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();
  final PasswordConfirmValidator _passwordConfirmValidator = PasswordConfirmValidator();

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          title: Text(
            'Cadastro',
            style: TextStyle(
              color: Colors.black,
              fontSize: sizeScreen.height * 0.028
            ),
          ),
          centerTitle: true,
        )
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
            SizedBox(height: sizeScreen.height * 0.06),
            Image.asset(
              'assets/images/logo.png',
              height: sizeScreen.height * 0.27,
            ),
            SizedBox(height: sizeScreen.height * 0.02),
            Form(
              key: _formRegister,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeScreen.height * 0.028
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Nome Completo',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: sizeScreen.height * 0.028,
                      ),
                      contentPadding: const EdgeInsets.only(top: 10),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 9, 145, 20)
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        size: sizeScreen.height * 0.055,
                        color: const Color.fromARGB(255, 55, 111, 60),
                      ),
                      suffixIcon: Container(width: 0)
                    ),
                    validator: (name) {
                      return _nameValidator.validate(name: name);
                    },
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  TextFormField(
                    controller: _cpfController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeScreen.height * 0.028
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'CPF',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: sizeScreen.height * 0.028
                      ),
                      contentPadding: const EdgeInsets.only(top: 10),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 9, 145, 20)
                        )
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.solidAddressCard,
                        size: sizeScreen.height * 0.04,
                        color: const Color.fromARGB(255, 55, 111, 60),
                      ),
                      suffixIcon: Container(width: 0)
                    ),
                    validator: (cpf) {
                      return _cpfValidator.validate(cpf: cpf);
                    },
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeScreen.height * 0.028
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'E-mail',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: sizeScreen.height * 0.028
                      ),
                      contentPadding: const EdgeInsets.only(top: 10),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 9, 145, 20)
                        )
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.solidEnvelope,
                        size: sizeScreen.height * 0.045,
                        color: const Color.fromARGB(255, 55, 111, 60),
                      ),
                      suffixIcon: Container(width: 0)
                    ),
                    validator: (email) {
                      return _emailValidator.validate(email: email);
                    },
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  TextFormField(
                    obscuringCharacter: '●',
                    textAlign: TextAlign.center,
                    controller: _passwordController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeScreen.height * 0.028
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Senha',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: sizeScreen.height * 0.028
                      ),
                      errorMaxLines: 3,
                      contentPadding: const EdgeInsets.only(top: 10),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 9, 145, 20)
                        )
                      ),
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
                          !_passwordVisible ? Icons.visibility_off : Icons.visibility,
                          size: sizeScreen.height * 0.035,
                          color: const Color.fromARGB(255, 55, 111, 60),
                        ),
                        style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                      )
                    ),
                    obscureText: !_passwordVisible,
                    validator: (password) {
                      return _passwordValidator.validate(password: password);
                    },
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  TextFormField(
                    obscuringCharacter: '●',
                    textAlign: TextAlign.center,
                    controller: _passwordConfirmController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeScreen.height * 0.028
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Confirmar Senha',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: sizeScreen.height * 0.028
                      ),
                      contentPadding: const EdgeInsets.only(top: 10),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 9, 145, 20)
                        )
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: sizeScreen.height * 0.05,
                        color: const Color.fromARGB(255, 55, 111, 60),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordConfirmVisible = !_passwordConfirmVisible;
                          });
                        },
                        icon: Icon(
                          !_passwordConfirmVisible ? Icons.visibility_off : Icons.visibility,
                          size: sizeScreen.height * 0.035,
                          color: const Color.fromARGB(255, 55, 111, 60),
                        ),
                        style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                      )
                    ),
                    obscureText: !_passwordConfirmVisible,
                    validator: (passwordConfirm) {
                      return _passwordConfirmValidator.validate(
                        password: _passwordController.text,
                        passwordConfirm: passwordConfirm
                      );
                    },
                  ),
                ],
              )
            ),
            SizedBox(height: sizeScreen.height * 0.03),
            SizedBox(
              height: sizeScreen.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  if (_formRegister.currentState!.validate()){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const EmailValidatorPage()),
                    );
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
                      'REGISTRAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.028
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
