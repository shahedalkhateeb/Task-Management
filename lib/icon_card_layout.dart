import 'package:flutter/material.dart';

class IconCardLayout extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const IconCardLayout({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1B4B),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.fromLTRB(24, 44, 24, 0),
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title,
                          style:  TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                       SizedBox(height: 10),
                      ...children,
                       SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF7A5AF8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x557A5AF8), blurRadius: 16, offset: Offset(0, 8)),
                ],
              ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.shield, color: Colors.white, size: 32),
                  Icon(Icons.lock, color: Color(0xFF7A5AF8), size: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}