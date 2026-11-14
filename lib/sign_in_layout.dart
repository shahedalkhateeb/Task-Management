import 'package:flutter/material.dart';

class SignInLayout extends StatelessWidget {
  final List<Widget> children;

  const SignInLayout({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1B4B),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text('Sign In',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827))),
                   SizedBox(height: 2),
                   Text('Sign in to my account',
                      style: TextStyle(fontSize: 11, color: Color(0xFF374151))),
                   SizedBox(height: 20),
                  ...children,
                   SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}