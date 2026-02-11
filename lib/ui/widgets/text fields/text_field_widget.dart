import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextField extends StatefulWidget {
  final bool isSecret;
  final String labelText;
  final IconData prefixIcon;
  final String obscuringCharacter;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;

  const PasswordTextField({
    super.key,
    this.validator,
    this.inputFormatters,
    this.isSecret = false,
    this.obscuringCharacter = '●',
    this.keyboardType = TextInputType.text,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
    this.enabled = true,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    // Define colors based on enabled state
    final Color iconColor = widget.enabled
        ? const Color.fromARGB(255, 55, 111, 60)
        : Colors.grey;
    final Color borderColor = widget.enabled
        ? const Color.fromARGB(255, 55, 111, 60)
        : Colors.grey.shade400;
    final Color fillColor = widget.enabled ? Colors.transparent : Colors.grey.shade200;

    return TextFormField(
      readOnly: !widget.enabled,
      obscureText: obscureText,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscuringCharacter: widget.obscuringCharacter,
      style: TextStyle(
        color: widget.enabled ? Colors.black : Colors.grey.shade700,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: !widget.enabled,
        fillColor: fillColor,
        errorMaxLines: 3,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.enabled ? null : Colors.grey.shade700,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: screenSize.height * .02),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor, width: 2)),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: iconColor,
        ),
        suffixIcon: widget.isSecret
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: iconColor))
            : null,
      ),
    );
  }
}
