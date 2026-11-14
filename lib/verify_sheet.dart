import 'package:flutter/material.dart';
import 'my_button.dart';
import 'code_boxes.dart';

Future<bool?> showVerifySheet(BuildContext context, String email) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
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
              child: const Icon(Icons.email_outlined, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 16),
            const Text('Email Verification Sent!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              'A verification code will be sent to the email ${email.isEmpty ? 'your email' : email} for your account verification process.',
              style: const TextStyle(fontSize: 11),
            ),
            const SizedBox(height: 16),
            const CodeBoxes(),
            const SizedBox(height: 14),
            const Row(
              children: [
                Text("Haven't received the verification code? ",
                    style: TextStyle(fontSize: 10)),
                Text('Resend it.',
                    style: TextStyle(fontSize: 10, color: Color(0xFF7A5AF8))),
              ],
            ),
            const SizedBox(height: 16),
            MyButton(
              text: 'Submit',
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      );
    },
  );
}