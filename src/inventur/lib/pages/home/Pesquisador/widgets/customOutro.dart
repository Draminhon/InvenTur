import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';

class textLabel extends StatelessWidget{
   final String name;

  const textLabel({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
     final sizeScreen = MediaQuery.sizeOf(context);
    
    return 
    
     Padding(
              padding: EdgeInsets.only(
                  top: sizeScreen.height * 0.02, left: sizeScreen.width * 0.05),
              child: Text(
                name,
                style: TextStyle(fontSize: sizeScreen.width * 0.04),
              ),
            );
  }

}