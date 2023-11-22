import 'package:flutter/material.dart';

class InputTextDecoration {
  InputTextDecoration._();

  static const InputDecoration textDecoration = InputDecoration(
    hintStyle: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.normal
    ),
    prefixIconConstraints: BoxConstraints(
      minWidth: 42,
      maxHeight: 22
    ),
    contentPadding: EdgeInsets.all(0),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 55, 111, 60)
      )
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 9, 145, 20),
        width: 2
      )
    )
  );
}