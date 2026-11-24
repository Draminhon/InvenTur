import 'package:flutter/material.dart';
import 'package:sistur/utils/app_constants.dart';

/// Fundo do avatar quando o usuário não tem foto de perfil salva: verde bem claro (sólido, para ficar
/// legível também sobre o cabeçalho verde do menu lateral).
const corFundoAvatarPadrao = Color(0xFFE6EFE7);

/// Ícone de perfil padrão (silhueta de pessoa no verde do projeto) para usar como `child` de um
/// [CircleAvatar] com `backgroundColor: corFundoAvatarPadrao` quando não há foto. Ajusta-se ao tamanho do avatar.
class IconePerfilPadrao extends StatelessWidget {
  const IconePerfilPadrao({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final diametro = constraints.biggest.shortestSide;
      return Icon(Icons.person_rounded, size: diametro * 0.6, color: AppConstants.MAIN_GREEN);
    });
  }
}
