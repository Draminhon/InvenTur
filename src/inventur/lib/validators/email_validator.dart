class EmailValidator {
  String? validate({String? email}) {
    if (email == null || email.trim().isEmpty) return 'O e-mail deve ser informado';

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) return 'O e-mail é inválido';  

    return null;
  }
}