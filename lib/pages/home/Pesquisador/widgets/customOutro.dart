import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class textLabel extends StatelessWidget {
  final String name;

  const textLabel({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Align(
      
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: EdgeInsets.only(top:  30.h, left: 80.w),
    child: Text(
      name,
      style: TextStyle(
        fontSize:  59.w,
        // fontWeight: FontWeight.w600
      ),
      textAlign: TextAlign.left,
    ),
  ),
);

  }
}

