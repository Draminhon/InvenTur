import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/auth/register_confirmation.dart';
import 'package:inventur/pages/widgets/text_field_widget.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/validators/name_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';



class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    final _formKey = GlobalKey<FormState>();
    final _formKey3 = GlobalKey<FormState>();


  final CPFValidator _cpfValidator = CPFValidator();

  final NameValidator _nameValidator = NameValidator();

  final EmailValidator _emailValidator = EmailValidator();

  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordController2 = TextEditingController();

  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');

  Future<void> registerUser(String username, String CPF, String email, String password) async{

    final url = Uri.parse(AppConstants.BASE_URI + AppConstants.REGISTER_URI);

  try{
      final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        
      },
      body: json.encode(<String, String>{
        'username': username,
        'CPF': CPF,
        'email': email,
        'password': password,
      })
    ); 

     
    
    if(response.statusCode == 201){
      print('Usuario registrado com sucesso');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return RegisterConfimation();
      }));
    }else{
      print('Erro ao registrar o usuário: ${response.body}');    }

     }catch(e){
      print('Erro: $e');
     }

  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    
    double paddingBottomTextField = screenSize.height * .015;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey3,
        child: SafeArea(

          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 150.h),
            reverse: true,
            child: SizedBox(
              width: screenSize.width,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Text('Cadastro', style: TextStyle(color: const Color.fromARGB(255, 55, 111, 60), fontSize: 90.h),),
                      const Text('Preencha os campos com suas informações.'),
                              SizedBox(height: paddingBottomTextField),
                    
                      const Divider(color:const Color.fromARGB(255, 55, 111, 60),thickness: 1.5, endIndent: 30,indent: 30,),
                              SizedBox(height: paddingBottomTextField),
                     
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text('Nome',style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: paddingBottomTextField),
                              
                              CustomTextField(
                                labelText: 'Insira seu nome completo',
                                controller: _nameController,
                                prefixIcon: Icons.person,
                                 validator: (name) {
                                   return _nameValidator.validate(name: name);
                                 },
                              ),
                              SizedBox(height: paddingBottomTextField),
                              const Text('CPF',style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: paddingBottomTextField),

                              CustomTextField(
                                labelText: 'Insira seu CPF',
                                controller: _cpfController,
                                keyboardType: TextInputType.number,
                                prefixIcon: FontAwesomeIcons.solidAddressCard,
                                 validator: (cpf) {
                                   return _cpfValidator.validate(cpf: cpf);
                                 },
                                inputFormatters: [cpfMask],
                              ),
                              SizedBox(height: paddingBottomTextField),
                              const Text('Email',style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: paddingBottomTextField),

                              CustomTextField(
                                labelText: 'Insira seu email',
                                controller: _emailController,
                                prefixIcon: FontAwesomeIcons.solidEnvelope,
                                keyboardType: TextInputType.emailAddress,
                                 validator: (email) {
                                   return _emailValidator.validate(email: email);
                                 },
                              ),
                              SizedBox(height: paddingBottomTextField),
                              const Text('Senha', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: paddingBottomTextField),

                              CustomTextField(
                                labelText: 'Insira sua senha',
                                prefixIcon: Icons.lock, 
                                controller: _passwordController, 
                                isSecret: true,
                                 validator: (password) {
                                   return _passwordValidator.validate(password: password);
                                 }, 
                              ),
                              SizedBox(height: paddingBottomTextField),
                              const Text('Confirmar Senha', style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: paddingBottomTextField),

                                CustomTextField(
                                labelText: 'Confirme sua senha',
                                prefixIcon: Icons.lock, 
                                controller: _passwordController2, 
                                isSecret: true,
                                 validator: (value) {
                                                    if (value == null || value.isEmpty) {
                    return 'Insira uma senha válida';
                  }else if(_passwordController.text != _passwordController2.text){
                    return 'As senhas precisam ser iguais!';
                  }
                  return null;
                                 }, 
                              ),
                              SizedBox(height: 160.h),

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
                                        vertical: screenSize.height * 0.012
                                      )
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 55, 111, 60)
                                    ),
                                    overlayColor: WidgetStateProperty.all(
                                      Colors.green[600]
                                    )
                                  ),
                                  
                                  onPressed: () async {

                                    if(_formKey.currentState!.validate()){
                                      _formKey.currentState!.save();

                                      final username = _nameController.text;
                                      final cpf = _cpfController.text.replaceAll('.','').replaceAll('-', '');
                                      final email = _emailController.text;
                                      final password = _passwordController.text;

                                      final result = await registerUser(username, cpf, email, password);
                                      await Future.delayed(const Duration(milliseconds: 500));

                                    }


                                  }, 
                                  child: Text(
                                    'Solicitar Cadastro',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenSize.height * .03
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
                    top: 20,
                    left: 8,
                    child: SafeArea(
                      child: IconButton(
                        tooltip: 'Voltar',
                        style: ButtonStyle(
                          overlayColor: WidgetStatePropertyAll(
                            Colors.green[100]
                          )
                        ),
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 9, 145, 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
