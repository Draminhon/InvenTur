import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  final String name;

  const CustomTextField({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Padding(
        padding: EdgeInsets.only(
          left: sizeScreen.width * 0.02,
          right: sizeScreen.width * 0.02,
          top: sizeScreen.height * 0.023,
        ),
        child: SizedBox(
            height: sizeScreen.height * 0.056,
            // child: Padding(
            //   padding: EdgeInsets.only(
            //     left: sizeScreen.width * 0.02, right: sizeScreen.width * 0.02, top: sizeScreen.height * 0.01),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: name,
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(
                    top: sizeScreen.height * 0.03,
                    left: sizeScreen.width * 0.05),
              ),
            )));
  }
}

class CustomTextDate extends StatelessWidget {
  const CustomTextDate({super.key});
  
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var inputFormat = DateFormat('dd/MM/yyyy');
    var outputFormat = DateFormat('dd/MM/yyyy');

    
    // outputFormat.format(inputFormat.parse('07/02/2024')),
             //   outputFormat.format(now),

    final sizeScreen = MediaQuery.sizeOf(context);

    return Padding(
        padding: EdgeInsets.only(
          left: sizeScreen.width * 0.02,
          right: sizeScreen.width * 0.02,
          top: sizeScreen.height * 0.023,
        ),
        child: SizedBox(
            height: sizeScreen.height * 0.056,
            // child: Padding(
            //   padding: EdgeInsets.only(
            //     left: sizeScreen.width * 0.02, right: sizeScreen.width * 0.02, top: sizeScreen.height * 0.01),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: '__/__/__',
                
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(
                    top: sizeScreen.height * 0.03,
                    left: sizeScreen.width * 0.05),
              ),
            )));
  }
}
