import 'package:flutter/material.dart';
import 'my_button.dart';
import 'icon_card_layout.dart';
import 'signin_page.dart';

class PasswordCreatedPage extends StatelessWidget {
  const PasswordCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IconCardLayout(
      title: 'Password Has Been Created',
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'To log in to your account, click the Sign in button and enter your email along with your new password.',
            style: TextStyle(fontSize: 10.5, color: Color(0xFF4B5563)),
          ),
        ),
        const SizedBox(height: 16),
        MyButton(
          text: 'Sign In',
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
                  (route) => false,
            );
          },
        ),
      ],
    );
  }
}