import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Validators{


String? validarCNPJ(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'CNPJ obrigatório';
  }

  // Remove caracteres não numéricos
  String cnpj = value.replaceAll(RegExp(r'\D'), '');

  if (cnpj.length != 14) {
    return 'CNPJ deve ter 14 dígitos';
  }

  // Valida CNPJ com dígitos verificadores
  if (!_isCNPJValido(cnpj)) {
    return 'CNPJ inválido';
  }

  return null;
}

bool _isCNPJValido(String cnpj) {
  if (RegExp(r'^(\d)\1{13}$').hasMatch(cnpj)) return false; // Ex: 00000000000000

  List<int> digitos = cnpj.split('').map(int.parse).toList();

  List<int> multiplicador1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  List<int> multiplicador2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  int soma1 = 0;
  for (int i = 0; i < 12; i++) {
    soma1 += digitos[i] * multiplicador1[i];
  }
  int resto1 = soma1 % 11;
  int digito1 = resto1 < 2 ? 0 : 11 - resto1;

  if (digitos[12] != digito1) return false;

  int soma2 = 0;
  for (int i = 0; i < 13; i++) {
    soma2 += digitos[i] * multiplicador2[i];
  }
  int resto2 = soma2 % 11;
  int digito2 = resto2 < 2 ? 0 : 11 - resto2;

  return digitos[13] == digito2;
}

String? validarNumero(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Este campo é obrigatório';
  }

  final numeroRegex = RegExp(r'^\d+$');

  if (!numeroRegex.hasMatch(value)) {
    return 'Insira apenas números';
  }

  return null; // válido
}
final cepFormatter = MaskTextInputFormatter(
  mask: '#####-###',
  filter: { "#": RegExp(r'[0-9]') },
);

final phoneFormatter = MaskTextInputFormatter(
  mask: "(##) # ####-####",
  filter: { "#": RegExp(r'[0-9]') },

);
  final cnpjFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
  );
}