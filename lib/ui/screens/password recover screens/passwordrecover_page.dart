import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/passwordOtp_page.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/recuperacao_layout.dart';
import 'package:sistur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:sistur/validators/email_validator.dart';

/// Etapa 1 de 3 da recuperação de senha: informar o e-mail para receber o código.
class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

  @override
  State<RecuperarSenha> createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  final _formKey = GlobalKey<FormState>();
  final _emailValidator = EmailValidator();
  final _emailController = TextEditingController();
  bool _carregando = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _enviarCodigo() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    final email = _emailController.text.trim().toLowerCase();
    setState(() => _carregando = true);
    try {
      await ApiService().post('password-reset/request/', data: {'email': email});
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PasswordotpPage(email: email)));
    } catch (e) {
      if (mounted) mostrarErroRecuperacao(context, mensagemDeErro(e, 'Não foi possível enviar o código. Tente novamente.'));
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RecuperacaoLayout(
      etapa: 1,
      icone: Icons.lock_reset_rounded,
      titulo: 'Esqueceu sua senha?',
      descricao: const Text(
        'Informe o e-mail da sua conta. Vamos enviar um código de 6 dígitos para você criar uma nova senha.',
      ),
      conteudo: [
        Form(
          key: _formKey,
          child: PasswordTextField(
            labelText: 'E-mail',
            controller: _emailController,
            prefixIcon: FontAwesomeIcons.solidEnvelope,
            keyboardType: TextInputType.emailAddress,
            validator: (email) => _emailValidator.validate(email: email),
          ),
        ),
        const SizedBox(height: 16),
        const AvisoRecuperacao(
          icone: Icons.mark_email_unread_outlined,
          texto: Text('O e-mail pode levar alguns minutos para chegar e, às vezes, vai para a caixa de '
              'Spam (Lixo eletrônico) ou Promoções.'),
        ),
      ],
      textoBotao: 'Enviar código',
      onConfirmar: _enviarCodigo,
      carregando: _carregando,
      onCancelar: () => Navigator.pop(context),
    );
  }
}
