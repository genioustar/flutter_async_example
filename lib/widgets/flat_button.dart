import 'package:flutter/material.dart';

class FlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isActive;

  const FlatButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: isActive ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          isActive ? Colors.deepPurple : Colors.grey,
        ),
        shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
        elevation: WidgetStateProperty.all<double>(0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.white : Colors.yellowAccent,
        ),
      ),
    );
  }
}
