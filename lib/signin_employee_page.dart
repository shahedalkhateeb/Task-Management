import 'package:flutter/material.dart';
import 'my_button.dart';
import 'my_text_field.dart';
import 'sign_in_layout.dart';
import 'remember_row.dart';
import 'or_divider.dart';
import 'sign_up_link.dart';
import 'home_page.dart';
import 'accounts.dart';
import 'signin_page.dart';
import 'signin_phone_page.dart';

class SignInEmployeePage extends StatefulWidget {
  const SignInEmployeePage({super.key});

  @override
  State<SignInEmployeePage> createState() => _SignInEmployeePageState();
}

class _SignInEmployeePageState extends State<SignInEmployeePage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? idError;
  String? passwordError;

  void signIn() {
    setState(() {
      idError = null;
      passwordError = null;
    });

    Account? account = findByCompanyId(idController.text);

    if (account == null) {
      setState(() {
        idError = 'Employee ID not found';
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
          label: 'Employee ID',
          hint: 'My Employee ID',
          icon: Icons.badge_outlined,
          controller: idController,
          errorText: idError,
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