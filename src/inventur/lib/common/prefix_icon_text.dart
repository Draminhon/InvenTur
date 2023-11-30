import 'package:flutter/material.dart';

Icon prefixIcon(IconData icon, Size sizeScreen) {
  return Icon(
    icon,
    // size: 32,
    size: sizeScreen.height * 0.04,
    color: const Color.fromARGB(255, 55, 111, 60),
  );
}