class EmailVerificationCodeValidator {
  String? validate({String? code, required String expectedCode}) {
    if (code == null || code.trim().isEmpty) return 'O código deve ser informado';

    if (code.length < 6) return 'O código é formado por 6 dígitos';

    final codeRegex = RegExp(r'^([0-9]{6})$');
    if (!codeRegex.hasMatch(code)) return 'O código é formado apenas por números';

    if (code != expectedCode) return 'Código inválido';

    return null;
  }
}