import 'package:flutter/material.dart';
import 'my_button.dart';
import 'code_boxes.dart';
import 'icon_card_layout.dart';
import 'new_password_page.dart';

class ForgotCodePage extends StatelessWidget {
  final String email;

  const ForgotCodePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return IconCardLayout(
      title: 'Forgot Password',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 10.5, color: Color(0xFF4B5563)),
              children: [
                const TextSpan(text: 'A reset code has been sent to '),
                TextSpan(
                  text: email,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const TextSpan(
                    text:
                    ', check your email to continue the password reset process.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const CodeBoxes(),
        const SizedBox(height: 14),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 10),
              children: [
                TextSpan(text: "Haven't received the verification code? "),
                TextSpan(
                  text: 'Resend it.',
                  style: TextStyle(
                      color: Color(0xFF7A5AF8), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        MyButton(
          text: 'Submit',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPasswordPage(email: email)),
            );
          },
        ),
      ],
    );
  }
}