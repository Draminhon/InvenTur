import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final List<String> accessLevels;
  final Function(String) onChanged;

  const CustomRadioButton({
    super.key, 
    required this.accessLevels, 
    required this.onChanged
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String _selectedAccessLevel = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton(widget.accessLevels[0]),
        _buildButton(widget.accessLevels[1]),
      ],
    );
  }

  Widget _buildButton(String accessLevel) {
    final isSelected = accessLevel == _selectedAccessLevel;
    final color = isSelected ? Colors.green : Colors.black;

    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedAccessLevel = accessLevel;
          widget.onChanged(accessLevel);
        });
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          color: color,
          width: 2
        ),
      ),
      child: Text(
        accessLevel,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}