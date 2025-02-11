import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  const DividerText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color.fromARGB(255, 9, 145, 20),
            thickness: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 9, 145, 20)
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color.fromARGB(255, 9, 145, 20),
            thickness: 2,
          ),
        ),
      ],
    );
  }
}