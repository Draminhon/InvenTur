import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/auth/email_validator_page.dart';
import 'package:inventur/pages/widgets/custom_text_field_widget.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/validators/name_validator.dart';
import 'package:inventur/validators/password_confirm_validator.dart';
import 'package:inventur/validators/password_validator.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formRegisterKey = GlobalKey<FormState>();

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
    
    double paddingBottomTextField = sizeScreen.height * 0.01;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: sizeScreen.width,
          height: sizeScreen.height,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: sizeScreen.height * 0.27,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 32,
                      right: 32,
                      bottom: 25,
                    ),
                    child: Form(
                      key: _formRegisterKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            labelText: 'Nome Completo',
                            controller: _nameController,
                            prefixIcon: Icons.person,
                            validator: (name) {
                              return _nameValidator.validate(name: name);
                            },
                          ),
                          SizedBox(height: paddingBottomTextField),
                          CustomTextField(
                            labelText: 'CPF',
                            controller: _cpfController,
                            keyboardType: TextInputType.number,
                            prefixIcon: FontAwesomeIcons.solidAddressCard,
                            validator: (cpf) {
                              return _cpfValidator.validate(cpf: cpf);
                            },
                          ),
                          SizedBox(height: paddingBottomTextField),
                          CustomTextField(
                            labelText: 'E-mail',
                            controller: _emailController,
                            prefixIcon: FontAwesomeIcons.solidEnvelope,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              return _emailValidator.validate(email: email);
                            },
                          ),
                          SizedBox(height: paddingBottomTextField),
                          CustomTextField(
                            labelText: 'Senha',
                            prefixIcon: Icons.lock, 
                            controller: _passwordController, 
                            isSecret: true,
                            validator: (password) {
                              return _passwordValidator.validate(password: password);
                            }, 
                          ),
                          SizedBox(height: paddingBottomTextField),
                          CustomTextField(
                            prefixIcon: Icons.lock, 
                            labelText: 'Confirmar Senha',
                            controller: _passwordConfirmController,
                            isSecret: true,
                            validator: (passwordConfirm) {
                              return _passwordConfirmValidator.validate(
                                password: _passwordController.text,
                                passwordConfirm: passwordConfirm
                              );
                            }, 
                          ),
                          SizedBox(height: paddingBottomTextField),
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
                                if (_formRegisterKey.currentState!.validate()){
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => EmailValidatorPage(email: _emailController.text)),
                                  );
                                }
                                // Navigator.push(
                                //   context, 
                                //   MaterialPageRoute(builder: (context) => EmailValidatorPage(email: _emailController.text)),
                                // );
                              }, 
                              child: const Text(
                                'Solicitar Cadastro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
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
