import 'package:flutter/material.dart';

SingleChildScrollView scrollView({required Size sizeScreen, Widget? child}) {
  return SingleChildScrollView(
    reverse: true,
    padding: EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 20,
      top: sizeScreen.height * 0.1
    ),
    child: child,
  );
}