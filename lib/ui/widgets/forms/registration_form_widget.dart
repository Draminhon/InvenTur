import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sistur/controllers/user_controller.dart';
import 'package:sistur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:sistur/validators/email_validator.dart';
import 'package:sistur/validators/name_validator.dart';
import 'package:sistur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sistur/services/interceptor_service.dart';

const _verde = Color.fromARGB(255, 55, 111, 60);

/// Cadastro de PESQUISADOR feito por um administrador. Administradores não cadastram outros administradores:
/// o perfil Administrador só é escolhido pelo próprio usuário no cadastro público do aplicativo.
/// ([userLevel] é mantido por compatibilidade com as telas que usam este formulário.)
class ResgistrationForm extends StatefulWidget {
  const ResgistrationForm({
    super.key,
    required this.userLevel,
    required this.userController,
  });

  final String userLevel;
  final UserController userController;

  @override
  State<ResgistrationForm> createState() => _ResgistrationFormState();
}

class _ResgistrationFormState extends State<ResgistrationForm> {
  final _formRegisterKey = GlobalKey<FormState>();

  final NameValidator _nameValidator = NameValidator();
  final EmailValidator _emailValidator = EmailValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  final phoneMask = MaskTextInputFormatter(mask: '(##) # ####-####');

  static const String _perfil = 'Pesquisador';
  bool _enviando = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  /// Envia o cadastro. Retorna null em caso de sucesso ou a mensagem de erro.
  Future<String?> _registrar() async {
    try {
      final response = await ApiService().post(
        'admin/register/',
        data: {
          'username': _nameController.text.trim(),
          'email': _emailController.text.trim().toLowerCase(),
          'password': _passwordController.text,
          'telefone': _telefoneController.text,
          'acessLevel': _perfil,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) return null;
      return 'Não foi possível cadastrar o usuário.';
    } on DioException catch (e) {
      final dados = e.response?.data;
      if (dados is Map) {
        // Mostra a primeira mensagem de validação devolvida pelo servidor (ex.: e-mail já cadastrado)
        for (final valor in dados.values) {
          if (valor is List && valor.isNotEmpty) return valor.first.toString();
          if (valor is String) return valor;
        }
      }
      return e.response == null
          ? 'Sem conexão. Tente novamente.'
          : 'Não foi possível cadastrar o usuário.';
    }
  }

  Future<void> _enviar() async {
    if (!_formRegisterKey.currentState!.validate()) return;
    setState(() => _enviando = true);
    final erro = await _registrar();
    if (!mounted) return;
    setState(() => _enviando = false);
    final mensagens = ScaffoldMessenger.of(context);
    if (erro != null) {
      mensagens.showSnackBar(SnackBar(content: Text(erro)));
      return;
    }
    mensagens.showSnackBar(SnackBar(
      backgroundColor: _verde,
      content: Text('$_perfil cadastrado com sucesso.'),
    ));
    await widget.userController.recarregarUsuarios();
    if (mounted) Navigator.pop(context);
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
              labelText: 'Insira o telefone',
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
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: screenSize.height * .012)),
                backgroundColor: WidgetStateProperty.all(_verde),
                overlayColor: WidgetStateProperty.all(Colors.green[600]),
              ),
              onPressed: _enviando ? null : _enviar,
              child: _enviando
                  ? const SizedBox(
                      width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(
                      'Cadastrar $_perfil',
                      style: TextStyle(color: Colors.white, fontSize: screenSize.height * .025),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
