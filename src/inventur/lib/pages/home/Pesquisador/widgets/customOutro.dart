import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';

class textLabel extends StatelessWidget {
  final String name;

  const textLabel({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Align(
      
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: EdgeInsets.only(top: sizeScreen.height * 0.03, left: sizeScreen.width * 0.06),
    child: Text(
      name,
      style: TextStyle(
        fontSize: sizeScreen.width * 0.04,
        // fontWeight: FontWeight.w600
      ),
      textAlign: TextAlign.left,
    ),
  ),
);

  }
}

