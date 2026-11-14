import 'package:flutter/material.dart';
import 'my_button.dart';
import 'my_text_field.dart';
import 'sign_in_layout.dart';
import 'remember_row.dart';
import 'or_divider.dart';
import 'sign_up_link.dart';
import 'home_page.dart';
import 'accounts.dart';
import 'signin_employee_page.dart';
import 'signin_phone_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  void signIn() {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    Account? account = findByEmail(emailController.text);

    if (account == null) {
      setState(() {
        emailError = "Email doesn't registered to any account";
      });
    } else if (account.password != passwordController.text) {
      setState(() {
        passwordError = 'Wrong Password';
      });
    } else {
      currentAccount = account;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInLayout(
      children: [
        MyTextField(
          label: 'Email',
          hint: 'My Email',
          icon: Icons.mail_outline,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          errorText: emailError,
        ),
        MyTextField(
          label: 'Password',
          hint: 'My Password',
          icon: Icons.lock_outline,
          isPassword: true,
          controller: passwordController,
          errorText: passwordError,
        ),
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
          text: 'Sign in With Phone',
          filled: false,
          icon: Icons.phone,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInPhonePage()),
            );
          },
        ),
        const SizedBox(height: 16),
        const SignUpLink(),
      ],
    );
  }
}