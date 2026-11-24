import 'package:flutter/material.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/changepasswordsucess_page.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/recuperacao_layout.dart';
import 'package:sistur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:sistur/validators/password_validator.dart';

/// Etapa 3 de 3 da recuperação de senha: criar a nova senha.
class MudarSenha extends StatefulWidget {
  const MudarSenha({super.key, required this.email});
  final String email;

  @override
  State<MudarSenha> createState() => _MudarSenhaState();
}

class _MudarSenhaState extends State<MudarSenha> {
  final _formKey = GlobalKey<FormState>();
  final _passwordValidator = PasswordValidator();
  final _senhaController = TextEditingController();
  final _confirmacaoController = TextEditingController();
  bool _carregando = false;

  @override
  void dispose() {
    _senhaController.dispose();
    _confirmacaoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() => _carregando = true);
    try {
      await ApiService().post(
        'password-reset/change-password/',
        data: {'email': widget.email, 'new_password': _senhaController.text},
      );
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ConfirmacaoNovaSenha()));
    } catch (e) {
      if (mounted) mostrarErroRecuperacao(context, mensagemDeErro(e, 'Não foi possível salvar a nova senha.'));
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RecuperacaoLayout(
      etapa: 3,
      icone: Icons.password_rounded,
      titulo: 'Crie uma nova senha',
      descricao: const Text('Escolha uma senha que você não use em outros serviços.'),
      conteudo: [
        Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            PasswordTextField(
              isSecret: true,
              labelText: 'Nova senha',
              controller: _senhaController,
              prefixIcon: Icons.lock_outline,
              validator: (senha) => _passwordValidator.validate(password: senha),
            ),
            const SizedBox(height: 14),
            PasswordTextField(
              isSecret: true,
              labelText: 'Confirmar nova senha',
              controller: _confirmacaoController,
              prefixIcon: Icons.lock_outline,
              validator: (valor) {
                if (valor == null || valor.isEmpty) return 'Confirme a nova senha';
                if (valor != _senhaController.text) return 'As senhas não são iguais';
                return null;
              },
            ),
          ]),
        ),
        const SizedBox(height: 14),
        // Regras da senha (as mesmas do PasswordValidator), visíveis antes do erro
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: verdeRecuperacao.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('A senha precisa ter:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[800])),
            const SizedBox(height: 6),
            for (final regra in const [
              'pelo menos 8 caracteres',
              'uma letra maiúscula e uma minúscula',
              'um número',
              r'um caractere especial: @ # $ % ^ & + =',
            ])
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(children: [
                  const Icon(Icons.check_rounded, size: 16, color: verdeRecuperacao),
                  const SizedBox(width: 6),
                  Expanded(child: Text(regra, style: TextStyle(fontSize: 13, color: Colors.grey[800]))),
                ]),
              ),
          ]),
        ),
      ],
      textoBotao: 'Salvar nova senha',
      onConfirmar: _salvar,
      carregando: _carregando,
      onCancelar: () => Navigator.pop(context),
    );
  }
}
