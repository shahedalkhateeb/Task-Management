import 'package:flutter/material.dart';
import 'my_button.dart';

class BottomButtonBar extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const BottomButtonBar({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2)),
        ],
      ),
      child: MyButton(text: text, enabled: enabled, onPressed: onPressed),
    );
  }
}