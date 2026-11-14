import 'package:flutter/material.dart';
import 'signup_page.dart';

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(fontSize: 11)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          },
          child: const Text('Sign Up Here',
              style: TextStyle(fontSize: 11, color: Color(0xFF7A5AF8))),
        ),
      ],
    );
  }
}