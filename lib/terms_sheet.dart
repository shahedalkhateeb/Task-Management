import 'package:flutter/material.dart';
import 'my_button.dart';

String termsText = '''Terms and Conditions:
Acceptance: By using the app, you agree to comply with all applicable terms and conditions.

Usage: This app is for personal use only and may not be used for commercial purposes without permission.

Account: You are responsible for the security of your account and all activities that occur within it.

Content: You must not upload content that violates copyright, privacy, or applicable laws.

Changes: We reserve the right to change the terms and conditions at any time and will notify you of these changes through the app or via email.

Privacy Policy:
Data Collection: We collect personal data such as name, email, and location to process transactions and improve our services.

Data Usage: Your data is used for internal purposes such as account management, usage analysis, and service offerings.

Security: We protect your data with appropriate security measures to prevent unauthorized access.

Data Sharing: We do not share your personal data with third parties without your consent, except as required by law.''';

Future<bool?> showTermsSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Terms & Conditions and\nPrivacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Text(termsText, style: const TextStyle(fontSize: 10)),
              ),
            ),
            const SizedBox(height: 16),
            MyButton(
              text: 'I Agree',
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            const SizedBox(height: 10),
            MyButton(
              text: 'Decline',
              filled: false,
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        ),
      );
    },
  );
}