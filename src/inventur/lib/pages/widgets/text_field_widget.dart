import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final bool isSecret;
  final String labelText;
  final IconData prefixIcon;
  final String obscuringCharacter;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.validator,
    this.inputFormatters,
    this.isSecret = false,
    this.obscuringCharacter = '●',
    this.keyboardType = TextInputType.text,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return TextFormField(
      obscureText: obscureText,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscuringCharacter: widget.obscuringCharacter,
      decoration: InputDecoration(
        isDense: true,
        errorMaxLines: 3,
        labelText: widget.labelText,
        contentPadding: EdgeInsets.symmetric(vertical: screenSize.height * .02),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: const Color.fromARGB(255, 55, 111, 60),
        ),
        suffixIcon: widget.isSecret
        ? IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          }, 
          icon: Icon(
            obscureText
            ? Icons.visibility
            : Icons.visibility_off,
            color: const Color.fromARGB(255, 55, 111, 60)
          )
        )
        : null,
      ),
    );
  }
}