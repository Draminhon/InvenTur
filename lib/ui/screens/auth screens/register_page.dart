import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/ui/screens/auth%20screens/register_confirmation.dart';
import 'package:inventur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/validators/cpf_validator.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:inventur/validators/name_validator.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  bool _isLoading = false;

  final CPFValidator _cpfValidator = CPFValidator();

  final NameValidator _nameValidator = NameValidator();

  final EmailValidator _emailValidator = EmailValidator();

  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordController2 = TextEditingController();

  final TextEditingController _telefoneController = TextEditingController();

  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  final phoneMask = MaskTextInputFormatter(mask: '(##) # ####-####');

  Future<void> registerUser(
      String username, String CPF, String email, String password, String telefone) async {
    final url = Uri.parse(AppConstants.BASE_URI + AppConstants.REGISTER_URI);

    setState(() {
      _isLoading = true;
    });

    FocusScope.of(context).unfocus();

    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, String>{
            'username': username,
            'CPF': CPF,
            'email': email,
            'password': password,
            'telefone': telefone,
          }));

      if (response.statusCode == 201) {
        print('Usuario registrado com sucesso');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const RegisterConfimation();
        }));
      } else {
        print('Erro ao registrar o usuário: ${response.body}');
      }
    } catch (e) {
      print('Erro: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future updateUsers(int user, String username, String CPF, String email,
      String password, String telefone) async {
    var url =
        Uri.parse('${AppConstants.BASE_URI}user/$user/');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    try {
      var response = await http.patch(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(<String, String>{
            'username': username,
            'CPF': CPF,
            'email': email,
            'password': password,
            'telefone': telefone
          }));

      if (response.statusCode == 200) {
        print('Usuario atualizado com sucesso: ${response.body}');

        Map<String, dynamic> userData = {
          'id': user,
          'name': username,
          'email': email,
          'cpf': CPF
        };
        prefs.setString('user_data', jsonEncode(userData));

        Navigator.pop(context);
        const snackBar =
            SnackBar(content: Text("Atualização realizada com sucesso!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print(
            'Erro ao atualizar usuario: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Erro na requisição: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final isChange = arguments['is_change'];
    final username = arguments['username'];
    final cpf = arguments['user_cpf'];
    final email = arguments['user_email'];
    final id = arguments['user_id'];
    final telefone = arguments['user_telefone'];
    double paddingBottomTextField = screenSize.height * .015;

    if (isChange == true) {
      _nameController.text = username;
      _cpfController.text = cpf;
      _emailController.text = email;
      _telefoneController.text = telefone;
    }

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
                      Text(
                        isChange == true ? 'Alterar Dados' : 'Cadastro',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 55, 111, 60),
                            fontSize: 90.h),
                      ),
                      const Text('Preencha os campos com suas informações.'),
                      SizedBox(height: paddingBottomTextField),
                      const Divider(
                        color: const Color.fromARGB(255, 55, 111, 60),
                        thickness: 1.5,
                        endIndent: 30,
                        indent: 30,
                      ),
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
                              const Text('Nome',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: paddingBottomTextField),
                              PasswordTextField(
                                labelText: 'Insira seu nome completo',
                                controller: _nameController,
                                prefixIcon: Icons.person,
                                validator: (name) {
                                  return _nameValidator.validate(name: name);
                                },
                              ),
                              SizedBox(height: paddingBottomTextField),
                              const Text('CPF',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: paddingBottomTextField),
                              PasswordTextField(
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
                              const Text('Email',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: paddingBottomTextField),
                              PasswordTextField(
                                labelText: 'Insira seu email',
                                controller: _emailController,
                                prefixIcon: FontAwesomeIcons.solidEnvelope,
                                keyboardType: TextInputType.emailAddress,
                                validator: (email) {
                                  return _emailValidator.validate(email: email);
                                },
                              ),
                              SizedBox(height: paddingBottomTextField),
                              const Text(
                                "Telefone",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: paddingBottomTextField,
                              ),
                              PasswordTextField(
                                  labelText: 'Insira seu telefone',
                                  controller: _telefoneController,
                                  inputFormatters: [phoneMask],
                                  keyboardType: TextInputType.phone,
                                  prefixIcon: FontAwesomeIcons.phone),
                              SizedBox(height: paddingBottomTextField),
                              const Text('Senha',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: paddingBottomTextField),
                              PasswordTextField(
                                labelText: isChange == true
                                    ? 'Insira sua nova senha'
                                    : 'Insira sua senha',
                                prefixIcon: Icons.lock,
                                controller: _passwordController,
                                isSecret: true,
                                validator: (password) {
                                  return _passwordValidator.validate(
                                      password: password);
                                },
                              ),
                              SizedBox(height: paddingBottomTextField),
                              const Text(
                                'Confirmar Senha',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: paddingBottomTextField),
                              PasswordTextField(
                                labelText: 'Confirme sua senha',
                                prefixIcon: Icons.lock,
                                controller: _passwordController2,
                                isSecret: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Insira uma senha válida';
                                  } else if (_passwordController.text !=
                                      _passwordController2.text) {
                                    return 'As senhas precisam ser iguais!';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: isChange == true ? 50.w : 160.h),
                              SizedBox(
                                height: screenSize.height * .07,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.symmetric(
                                                vertical:
                                                    screenSize.height * 0.012)),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 55, 111, 60)),
                                        overlayColor: WidgetStateProperty.all(
                                            Colors.green[600])),
                                    onPressed: () async {
                                      if (isChange == true) {
                                        _formKey.currentState!.save();

                                        final cpf = _cpfController.text
                                            .replaceAll('.', '')
                                            .replaceAll('-', '');
                                        updateUsers(
                                            id,
                                            _nameController.text,
                                            cpf,
                                            _emailController.text,
                                            _passwordController.text,
                                            _telefoneController.text);
                                      } else {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          final username = _nameController.text;
                                          final cpf = _cpfController.text
                                              .replaceAll('.', '')
                                              .replaceAll('-', '');
                                          final email = _emailController.text;
                                          final password =
                                              _passwordController.text;
                                          final telefone = _telefoneController.text;
                                          final result = await registerUser(
                                              username, cpf, email, password, telefone);
                                          

                                          print(telefone);
                                          await Future.delayed(const Duration(
                                              milliseconds: 500));
                                        }
                                      }
                                    },
                                    child: Text(
                                      isChange == true
                                          ? 'Confirmar Alterações'
                                          : 'Solicitar Cadastro',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenSize.height * .03),
                                    )),
                              ),
                              isChange == true
                                  ? SizedBox(
                                      height: 50.w,
                                    )
                                  : SizedBox(),
                              isChange == true
                                  ? SizedBox(
                                      height: screenSize.height * .07,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              padding: WidgetStateProperty.all(
                                                  EdgeInsets.symmetric(
                                                      vertical:
                                                          screenSize.height *
                                                              0.012)),
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.red),
                                              overlayColor:
                                                  WidgetStateProperty.all(
                                                      Colors.green[600])),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancelar',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    screenSize.height * .03),
                                          )),
                                    )
                                  : const SizedBox(),
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
                            overlayColor:
                                WidgetStatePropertyAll(Colors.green[100])),
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 9, 145, 20),
                        ),
                      ),
                    ),
                  ),
                  if (_isLoading)
                    Positioned(
                      top: 1000.w,
                      left: 600.w,
                      child: AbsorbPointer(
                        absorbing: true,
                        child: Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withAlpha(5),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withAlpha(5)),
                            ),
                            SizedBox(
                                height: 150.w,
                                width: 150.w,
                                child: CircularProgressIndicator())
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
