class NameValidator {
  String? validate({String? name}) {
    if (name == null || name.trim().isEmpty) return 'O nome deve ser informado';

    if (name.length > 250) return 'O nome deve possuir no máximo 250 caracteres';

    final nameRegex = RegExp(r'^[a-zA-Z \u00C0-\u017F]+$');
    if (!nameRegex.hasMatch(name)) return 'O nome deve possuir apenas letras';

    return null;
  }
}