import 'package:flutter/material.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/recuperacao_layout.dart';

/// Conclusão da recuperação de senha.
class ConfirmacaoNovaSenha extends StatelessWidget {
  const ConfirmacaoNovaSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // não volta para as etapas anteriores
      child: RecuperacaoLayout(
        icone: Icons.check_circle_rounded,
        titulo: 'Senha alterada!',
        descricao: const Text('Sua senha foi alterada com sucesso. Use a nova senha para entrar no SisTur.'),
        textoBotao: 'Ir para o login',
        // Limpa a pilha de telas de recuperação e volta ao login
        onConfirmar: () => Navigator.pushNamedAndRemoveUntil(context, '/Login', (_) => false),
      ),
    );
  }
}
