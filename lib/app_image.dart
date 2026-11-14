import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;

  const AppImage(
      this.path, {
        super.key,
        this.width,
        this.height,
        this.fit = BoxFit.contain,
        this.alignment = Alignment.center,
      });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: const Color(0x22000000),
          child: const Icon(Icons.image, size: 14, color: Colors.white70),
        );
      },
    );
  }
}