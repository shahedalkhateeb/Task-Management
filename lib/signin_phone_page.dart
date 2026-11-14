import 'package:flutter/material.dart';
import 'my_button.dart';
import 'phone_field.dart';
import 'sign_in_layout.dart';
import 'remember_row.dart';
import 'or_divider.dart';
import 'sign_up_link.dart';
import 'otp_page.dart';
import 'accounts.dart';
import 'signin_page.dart';
import 'signin_employee_page.dart';

class SignInPhonePage extends StatefulWidget {
  const SignInPhonePage({super.key});

  @override
  State<SignInPhonePage> createState() => _SignInPhonePageState();
}

class _SignInPhonePageState extends State<SignInPhonePage> {
  TextEditingController phoneController = TextEditingController();
  String? phoneError;

  void signIn() {
    if (findByPhone(phoneController.text) == null) {
      setState(() {
        phoneError = 'This phone number is not registered';
      });
      return;
    }

    setState(() {
      phoneError = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpPage(phone: phoneController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignInLayout(
      children: [
        PhoneField(controller: phoneController, errorText: phoneError),
        const RememberRow(),
        const SizedBox(height: 14),
        MyButton(text: 'Sign In', onPressed: signIn),
        const SizedBox(height: 16),
        const OrDivider(),
        const SizedBox(height: 16),
        MyButton(
          text: 'Sign in With Employee ID',
          filled: false,
          icon: Icons.badge,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInEmployeePage()),
            );
          },
        ),
        const SizedBox(height: 10),
        MyButton(
          text: 'Sign in With Email',
          filled: false,
          icon: Icons.email,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          },
        ),
        const SizedBox(height: 16),
        const SignUpLink(),
      ],
    );
  }
}