class EmailValidator {
  String? validate({String? email}) {
    if (email == null || email.trim().isEmpty) return 'O e-mail deve ser informado';

    // Aceita "+" e pontos no nome, subdomínios e domínios de qualquer tamanho (.com, .gov.br, .online...)
    final emailRegex = RegExp(r'^[\w.+-]+@([\w-]+\.)+[A-Za-z]{2,}$');
    if (!emailRegex.hasMatch(email.trim())) return 'O e-mail é inválido';

    return null;
  }
}