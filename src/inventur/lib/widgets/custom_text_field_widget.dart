import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Size sizeScreen;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final IconData prefixIcon;
  final double prefixIconSize;
  final String obscuringCharacter;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    this.suffixIcon,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    required this.validator,
    required this.sizeScreen,
    required this.prefixIconSize,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: widget.controller,
      obscuringCharacter: widget.obscuringCharacter,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        color: Colors.black,
        fontSize: widget.sizeScreen.height * 0.023,
      ),
      decoration: InputDecoration(
        isDense: true,
        errorMaxLines: 3,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: widget.sizeScreen.height * 0.028,
        ),
        contentPadding: const EdgeInsets.only(top: 10),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 55, 111, 60))
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 9, 145, 20)
          ),
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          size: widget.sizeScreen.height * widget.prefixIconSize,
          color: const Color.fromARGB(255, 55, 111, 60),
        ),
        suffixIcon: widget.suffixIcon,
      ),
      validator: widget.validator,
      obscureText: widget.obscureText,
    );
  }
}