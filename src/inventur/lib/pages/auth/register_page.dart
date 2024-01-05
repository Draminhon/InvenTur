import 'package:flutter/material.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/name_validator.dart';
import 'package:inventur/widgets/custom_text_field_widget.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:inventur/pages/auth/email_validator_page.dart';
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
    final sizeScreen = MediaQuery.sizeOf(context);

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
          left: 10,
          right: 10,
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
                  CustomTextField(
                    hintText: 'Nome Completo',
                    prefixIconSize: 0.04,
                    sizeScreen: sizeScreen,
                    prefixIcon: Icons.person,
                    controller: _nameController,
                    suffixIcon: Container(width: 0),
                    validator: (name) {
                      return _nameValidator.validate(name: name);
                    },
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  CustomTextField(
                    hintText: 'CPF',
                    prefixIconSize: 0.025,
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
                    hintText: 'E-mail',
                    prefixIconSize: 0.027,
                    sizeScreen: sizeScreen,
                    controller: _emailController,
                    suffixIcon: Container(width: 0),
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: FontAwesomeIcons.solidEnvelope,
                    validator: (email) {
                      return _emailValidator.validate(email: email);
                    },
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  CustomTextField(
                    hintText: 'Senha',
                    prefixIconSize: 0.035,
                    prefixIcon: Icons.lock, 
                    sizeScreen: sizeScreen, 
                    controller: _passwordController, 
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        !_passwordVisible ? Icons.visibility_off : Icons.visibility,
                        size: sizeScreen.height * 0.025,
                        color: const Color.fromARGB(255, 55, 111, 60),
                      ),
                      style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                    ),
                    obscureText: !_passwordVisible,
                    validator: (password) {
                      return _passwordValidator.validate(password: password);
                    }, 
                  ),
                  SizedBox(height: sizeScreen.height * 0.01),
                  CustomTextField(
                    prefixIconSize: 0.035,
                    prefixIcon: Icons.lock,
                    sizeScreen: sizeScreen,
                    hintText: 'Confirmar Senha',
                    controller: _passwordConfirmController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordConfirmVisible = !_passwordConfirmVisible;
                        });
                      },
                      icon: Icon(
                        !_passwordConfirmVisible ? Icons.visibility_off : Icons.visibility,
                        size: sizeScreen.height * 0.025,
                        color: const Color.fromARGB(255, 55, 111, 60),
                      ),
                      style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
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
                  // if (_formRegister.currentState!.validate()){
                  //   Navigator.push(
                  //     context, 
                  //     MaterialPageRoute(builder: (context) => EmailValidatorPage(email: _emailController.text)),
                  //   );
                  // }
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => EmailValidatorPage(email: _emailController.text)),
                  );
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
