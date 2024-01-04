class CPFValidator {
  String? validate({String? cpf}) {
    if (cpf == null || cpf.trim().isEmpty) return 'O CPF deve ser informado';

    final cpfRegex = RegExp(
        r'^([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}-?[0-9]{2})|^([0-9]{11})$');
    if (!cpfRegex.hasMatch(cpf.trim()) || !validateCheckDigits(cpf: cpf)) return 'O CPF informado é inválido';

    return null;
  }

  bool validateCheckDigits({String? cpf}) {
    String cpfNumeric = cpf!.replaceAll('.', '').replaceAll('-', '');

    int firstCheckDigit = 0;
    for (int i = 0; i < cpfNumeric.length - 2; i++) {
      firstCheckDigit += int.parse(cpfNumeric[i]) * (10 - i);
    }

    firstCheckDigit %= 11;
    firstCheckDigit = firstCheckDigit == 0 || firstCheckDigit == 1 
    ? 0 
    : 11 - firstCheckDigit;

    int secondCheckDigit = 0;
    for (int i = 0; i < cpfNumeric.length - 1; i++) {
      secondCheckDigit += int.parse(cpfNumeric[i]) * (11 - i);
    }

    secondCheckDigit %= 11;
    secondCheckDigit = secondCheckDigit == 0 || secondCheckDigit == 1 
    ? 0 
    : 11 - secondCheckDigit;

    return (firstCheckDigit == int.parse(cpfNumeric[9])) && 
      (secondCheckDigit == int.parse(cpfNumeric[10]));
  }
}
