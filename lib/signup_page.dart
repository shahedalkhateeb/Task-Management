import 'package:flutter/material.dart';
import 'my_button.dart';
import 'my_text_field.dart';
import 'phone_field.dart';
import 'terms_sheet.dart';
import 'verify_sheet.dart';
import 'empty_home_page.dart';
import 'signin_page.dart';
import 'accounts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  String? emailError;
  String? phoneError;
  String? companyError;
  String? passwordError;
  String? confirmError;

  bool agree = false;

  void onCheckboxChanged(bool? value) async {
    if (value == true) {
      bool? accepted = await showTermsSheet(context);
      if (!mounted) return;
      setState(() {
        agree = accepted == true;
      });
    } else {
      setState(() {
        agree = false;
      });
    }
  }

  void onSignUp() async {
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String company = companyController.text.trim();
    String password = passwordController.text;
    String confirm = confirmController.text;

    setState(() {
      emailError = null;
      phoneError = null;
      companyError = null;
      passwordError = null;
      confirmError = null;

      if (!email.contains('@') || !email.contains('.')) {
        emailError = 'Enter a valid email';
      } else if (findByEmail(email) != null) {
        emailError = 'This email is already registered';
      }

      if (normalizePhone(phone).isEmpty) {
        phoneError = 'Enter your phone number';
      } else if (findByPhone(phone) != null) {
        phoneError = 'This phone number is already registered';
      }

      if (company.isEmpty) {
        companyError = 'Enter your company ID';
      } else if (findByCompanyId(company) != null) {
        companyError = 'This company ID is already registered';
      }

      if (password.length < 6) {
        passwordError = 'Password must be at least 6 characters';
      }

      if (confirm != password) {
        confirmError = 'Passwords do not match';
      }
    });

    bool hasError = emailError != null ||
        phoneError != null ||
        companyError != null ||
        passwordError != null ||
        confirmError != null;
    if (hasError) return;

    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms & conditions')),
      );
      return;
    }

    bool? verified = await showVerifySheet(context, email);
    if (!mounted) return;

    if (verified == true) {
      Account account = Account(
        email: email,
        phone: phone,
        companyId: company,
        password: password,
      );
      accounts.add(account);
      currentAccount = account;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const EmptyHomePage(showWelcome: true)),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF7A5AF8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.work_outline, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text('Work Mate',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('Register Using Your Credentials',
                  style: TextStyle(fontSize: 11)),
              const SizedBox(height: 24),

              MyTextField(
                label: 'Email',
                hint: 'Enter Your Email',
                icon: Icons.email_outlined,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: emailError,
              ),
              PhoneField(
                controller: phoneController,
                errorText: phoneError,
              ),
              MyTextField(
                label: 'Company ID',
                hint: 'Enter Company ID',
                icon: Icons.badge_outlined,
                controller: companyController,
                errorText: companyError,
              ),
              MyTextField(
                label: 'Password',
                hint: 'My Password',
                icon: Icons.lock_outline,
                isPassword: true,
                controller: passwordController,
                errorText: passwordError,
              ),
              MyTextField(
                label: 'Confirm Password',
                hint: 'Confirm My Password',
                icon: Icons.lock_outline,
                isPassword: true,
                controller: confirmController,
                errorText: confirmError,
              ),

              Row(
                children: [
                  Checkbox(
                    value: agree,
                    activeColor: const Color(0xFF7A5AF8),
                    onChanged: onCheckboxChanged,
                  ),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 11, color: Colors.black),
                        children: [
                          TextSpan(text: 'I agree with '),
                          TextSpan(
                              text: 'terms & conditions',
                              style: TextStyle(color: Color(0xFF7A5AF8))),
                          TextSpan(text: ' and '),
                          TextSpan(
                              text: 'privacy policy',
                              style: TextStyle(color: Color(0xFF7A5AF8))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              MyButton(text: 'Sign Up', onPressed: onSignUp),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ',
                      style: TextStyle(fontSize: 12)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInPage()),
                      );
                    },
                    child: const Text('Sign in here',
                        style: TextStyle(fontSize: 12, color: Color(0xFF7A5AF8))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}