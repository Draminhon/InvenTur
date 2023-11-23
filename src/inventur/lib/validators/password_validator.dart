class PasswordValidator {
  String? validate({String? password}) {
    if (password == null || password.trim().isEmpty) return 'A senha deve ser informada';

    if (password.length < 8) return 'A senha deve possuir pelo menos 8 caracteres';

    final alphanumeric = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=]).{8,}$');

    if (!alphanumeric.hasMatch(password)) {
      return 'A senha deve conter pelo menos: uma letra maiúscula, uma letra minúscula, um número e um caractere especial';
    }

    return null;
  }
}
