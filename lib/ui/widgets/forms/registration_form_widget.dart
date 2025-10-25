import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/controllers/user_controller.dart';
import 'package:inventur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/validators/name_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  final TextEditingController _telefoneController = TextEditingController();

  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  final phoneMask = MaskTextInputFormatter(mask: '(##) # ####-####');


  Future<void> registerUser(String username, String CPF, String email, String password, String telefone) async{

    final url = Uri.parse('${AppConstants.BASE_URI}admin/register/');

  try{
          final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
      final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
      body: json.encode(<String, String>{
        'username': username,
        'CPF': CPF,
        'email': email,
        'password': password,
        'telefone': telefone
      })
    ); 

     
    
    if(response.statusCode == 201){
      print('Usuario registrado com sucesso');
    }else{
      print('Erro ao registrar o usuário: ${response.body}');    }

     }catch(e){
      print('Erro: $e');
     }

  }


  @override
  Widget build(BuildContext context) {


    final screenSize = MediaQuery.sizeOf(context);
    
    double paddingBottomTextField = screenSize.height * 0.02;

    return Form(
      key: _formRegisterKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PasswordTextField(
            labelText: 'Nome Completo',
            controller: _nameController,
            prefixIcon: Icons.person,
            validator: (name) {
              return _nameValidator.validate(name: name);
            },
          ),
          SizedBox(height: paddingBottomTextField),
          PasswordTextField(
            labelText: 'CPF',
            controller: _cpfController,
            keyboardType: TextInputType.number,
            prefixIcon: FontAwesomeIcons.solidAddressCard,
            validator: (cpf) {
              return _cpfValidator.validate(cpf: cpf);
            },
            inputFormatters: [cpfMask],
          ),
          SizedBox(height: 
          paddingBottomTextField),
                PasswordTextField(
                                  labelText: 'Insira seu telefone',
                                  controller: _telefoneController,
                                  inputFormatters: [phoneMask],
                                  keyboardType: TextInputType.phone,
                                  prefixIcon: FontAwesomeIcons.phone),
          SizedBox(height: paddingBottomTextField),
          PasswordTextField(
            labelText: 'E-mail',
            controller: _emailController,
            prefixIcon: FontAwesomeIcons.solidEnvelope,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              return _emailValidator.validate(email: email);
            },
          ),
          SizedBox(height: paddingBottomTextField),
          PasswordTextField(
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
            height: screenSize.height * .07,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(
                    vertical: screenSize.height * .012
                  )
                ),
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 55, 111, 60)
                ),
                overlayColor: WidgetStateProperty.all(
                  Colors.green[600]
                )
              ),
              onPressed: () async{
                if (_formRegisterKey.currentState!.validate()){
                
                                      final username = _nameController.text;
                                      final cpf = _cpfController.text.replaceAll('.','').replaceAll('-', '');
                                      final email = _emailController.text;
                                      final password = _passwordController.text;
                                      final telefone = _telefoneController.text;
                                      final result = await registerUser(username, cpf, email, password, telefone);
                                      Navigator.pop(context);
                }
              }, 
              child: Text(
                userLevel == userController.primaryLevel
                ? 'Cadastrar'
                : 'Solicitar Cadastro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.height * .03
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}