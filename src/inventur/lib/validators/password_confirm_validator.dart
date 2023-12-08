import 'package:inventur/validators/password_validator.dart';

class PasswordConfirmValidator {
  validate({String? passwordConfirm, required String password}) {
    final PasswordValidator passwordValidator = PasswordValidator();

    if (passwordConfirm == null || passwordConfirm.trim().isEmpty) return 'Confirme a senha';

    if (passwordValidator.validate(password: password) != null) return 'Senha inválida';
    
    if (passwordConfirm != password) return 'As senhas não coincidem';
  }
}