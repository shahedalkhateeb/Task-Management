import 'package:flutter/material.dart';
import 'my_button.dart';
import 'profile_page.dart';

void showWelcomeSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF7A5AF8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 16),
            const Text('Welcome To Work Mate!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              'To enhance your user experience, please set up your profile first. This will help us tailor the app to your needs and ensure you get the most out of our features!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11),
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Set Up My Profile',
              onPressed: () {
                Navigator.pop(sheetContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            const SizedBox(height: 10),
            MyButton(
              text: 'Explore The App First',
              filled: false,
              onPressed: () {
                Navigator.pop(sheetContext);
              },
            ),
          ],
        ),
      );
    },
  );
}