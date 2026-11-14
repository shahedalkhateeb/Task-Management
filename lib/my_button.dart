import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool filled;
  final IconData? icon;
  final bool enabled;
  final bool dark;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.filled = true,
    this.icon,
    this.enabled = true,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = filled ? Colors.white : const Color(0xFF7B4DFF);

    List<Color> gradientColors = dark
        ? const [Color(0xFF3F3F46), Color(0xFF18181B)]
        : enabled
        ? const [Color(0xFF8B5CFF), Color(0xFF5B2DEE)]
        : const [Color(0xFFCDBFFF), Color(0xFFC0AEFF)];

    return Container(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        gradient: filled
            ? LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
            : null,
        color: filled ? null : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: filled ? null : Border.all(color: const Color(0xFF7B4DFF)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: enabled ? onPressed : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: textColor),
                 SizedBox(width: 6),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}