import 'package:flutter/material.dart';
import 'app_image.dart';

class PurpleHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Widget card;

  const PurpleHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: top + 150,
          decoration: const BoxDecoration(
            color: Color(0xFF7A5AF8),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),

        Positioned(
          left: 20,
          top: top + 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style:  TextStyle(color: Colors.white70, fontSize: 10)),
            ],
          ),
        ),

        Positioned(
          right: 16,
          top: top + 8,
          child: AppImage(imagePath, width: 90, height: 80),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(16, top + 80, 16, 0),
          child: SizedBox(width: double.infinity, child: card),
        ),
      ],
    );
  }
}