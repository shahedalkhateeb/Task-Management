import 'package:flutter/material.dart';
import 'forgot_password_page.dart';

class RememberRow extends StatefulWidget {
  const RememberRow({super.key});

  @override
  State<RememberRow> createState() => _RememberRowState();
}

class _RememberRowState extends State<RememberRow> {
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: checked,
            activeColor: const Color(0xFF7A5AF8),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (value) {
              setState(() {
                checked = value!;
              });
            },
          ),
        ),
        const SizedBox(width: 6),
        const Text('Remember Me', style: TextStyle(fontSize: 11)),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
            );
          },
          child: const Text('Forgot Password',
              style: TextStyle(fontSize: 11, color: Color(0xFF7A5AF8))),
        ),
      ],
    );
  }
}