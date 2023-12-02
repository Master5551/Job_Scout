import 'package:flutter/material.dart';

class IconwithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor; // Add a textColor property

  IconwithText(this.icon, this.text, {required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor, // You can adjust the icon color here
        ),
        SizedBox(width: 5), // Adjust the spacing as needed
        Text(
          text,
          style: TextStyle(
            color: textColor, // Use the provided textColor
            // Add more text styling properties if needed
          ),
        ),
      ],
    );
  }
}