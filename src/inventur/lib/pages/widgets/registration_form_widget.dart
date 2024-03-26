import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/widgets/text_field_widget.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/validators/name_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ResgistrationForm extends StatelessWidget {
  ResgistrationForm({
    super.key,
    required this.userLevel,
    required this.userController,
  });

  final String userLevel;
  final UserController userController;
  
  final _formRegisterKey = GlobalKey<FormState>();

  final CPFValidator _cpfValidator = CPFValidator();
  final NameValidator _nameValidator = NameValidator();
  final EmailValidator _emailValidator = EmailValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    
    double paddingBottomTextField = sizeScreen.height * 0.02;

    return Form(
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
            inputFormatters: [cpfMask],
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
                if (_formRegisterKey.currentState!.validate()){}
              }, 
              child: Text(
                userLevel == userController.primaryLevel
                ? 'Cadastrar'
                : 'Solicitar Cadastro',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}