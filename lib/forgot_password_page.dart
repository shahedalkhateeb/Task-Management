import 'package:flutter/material.dart';
import 'my_button.dart';
import 'my_text_field.dart';
import 'icon_card_layout.dart';
import 'forgot_code_page.dart';
import 'accounts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  String? emailError;

  bool get hasEmail => emailController.text.trim().isNotEmpty;

  void sendCode() {
    String email = emailController.text.trim();

    if (findByEmail(email) == null) {
      setState(() {
        emailError = "Email doesn't registered to any account";
      });
      return;
    }

    setState(() {
      emailError = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotCodePage(email: email)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconCardLayout(
      title: 'Forgot Password',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            hasEmail
                ? 'Reset password code will be sent to your email to reset your password.'
                : 'A verification code will be sent to your email to reset your password.',
            style: const TextStyle(fontSize: 10.5, color: Color(0xFF4B5563)),
          ),
        ),
        const SizedBox(height: 16),
        MyTextField(
          label: 'Email',
          hint: 'My email',
          icon: Icons.mail_outline,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          errorText: emailError,
          onChanged: (value) {
            setState(() {});
          },
        ),
        MyButton(
          text: 'Send Verification Code',
          enabled: hasEmail,
          onPressed: sendCode,
        ),
      ],
    );
  }
}