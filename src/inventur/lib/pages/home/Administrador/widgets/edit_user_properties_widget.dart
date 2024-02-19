import 'package:flutter/material.dart';

class EditUserProperties extends StatefulWidget {
  const EditUserProperties({super.key});

  @override
  State<EditUserProperties> createState() => _EditUserPropertiesState();
}

class _EditUserPropertiesState extends State<EditUserProperties> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {}, 
      icon: const Icon(
        Icons.edit,
      )
    );
  }
}