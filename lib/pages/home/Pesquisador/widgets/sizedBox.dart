import 'package:flutter/material.dart';

class SizedB extends StatelessWidget {
  final String name;

  const SizedB({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Container(
      width: sizeScreen.width * 0.5,
      //height: sizeScreen.height * 0.22,
      padding: EdgeInsets.only(top: sizeScreen.height * 0.02),
    
    );
  }
}
