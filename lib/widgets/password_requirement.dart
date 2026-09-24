import 'package:flutter/material.dart';

class PasswordRequirement extends StatelessWidget {
  final String text;
  final bool passed;

  const PasswordRequirement({
    super.key,
    required this.text,
    required this.passed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            passed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: passed ? Colors.greenAccent : Colors.white38,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: passed ? Colors.greenAccent : Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}