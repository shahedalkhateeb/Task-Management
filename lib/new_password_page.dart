import 'package:flutter/material.dart';
import 'my_button.dart';
import 'my_text_field.dart';
import 'icon_card_layout.dart';
import 'password_created_page.dart';
import 'accounts.dart';

class NewPasswordPage extends StatefulWidget {
  final String email;

  const NewPasswordPage({super.key, required this.email});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  String? passwordError;
  String? confirmError;

  void submit() {
    setState(() {
      passwordError = null;
      confirmError = null;

      if (passwordController.text.length < 6) {
        passwordError = 'Password must be at least 6 characters';
      }
      if (passwordController.text != confirmController.text) {
        confirmError = 'Passwords do not match';
      }
    });

    if (passwordError != null || confirmError != null) return;

    Account? account = findByEmail(widget.email);
    if (account != null) {
      account.password = passwordController.text;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PasswordCreatedPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconCardLayout(
      title: 'Set a New Password',
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Please set a new password to secure your Work Mate account.',
            style: TextStyle(fontSize: 10.5, color: Color(0xFF4B5563)),
          ),
        ),
        const SizedBox(height: 16),
        MyTextField(
          label: 'Password',
          hint: 'Input Password',
          icon: Icons.lock_outline,
          isPassword: true,
          controller: passwordController,
          errorText: passwordError,
        ),
        MyTextField(
          label: 'Confirm Password',
          hint: 'Re Enter Your Password',
          icon: Icons.lock_outline,
          isPassword: true,
          controller: confirmController,
          errorText: confirmError,
        ),
        MyButton(text: 'Submit', onPressed: submit),
      ],
    );
  }
}