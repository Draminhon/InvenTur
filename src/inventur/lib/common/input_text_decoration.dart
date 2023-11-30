import 'package:flutter/material.dart';

InputDecoration textDecoration({String? hintText, Widget? prefixIcon, Widget? suffix, int? errorMaxLines, required Size sizeScreen}) {
  return InputDecoration(
    errorMaxLines: errorMaxLines,
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: sizeScreen.height * 0.028,
      color: Colors.black,
      fontWeight: FontWeight.normal
    ),
    prefixIcon: prefixIcon,
    prefixIconConstraints: BoxConstraints(
      minWidth: 42,
      // maxHeight: 22
      maxHeight: sizeScreen.height * 0.025
    ),
    suffix: suffix,
    contentPadding: const EdgeInsets.all(0),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 55, 111, 60)
      )
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 9, 145, 20),
        width: 2
      )
    )
  );
}