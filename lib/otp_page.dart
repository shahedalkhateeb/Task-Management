import 'package:flutter/material.dart';
import 'my_button.dart';
import 'code_boxes.dart';
import 'home_page.dart';
import 'accounts.dart';

class OtpPage extends StatelessWidget {
  final String phone;

  const OtpPage({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1B4B),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.fromLTRB(24, 44, 24, 0),
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Text('Sign In Phone Number',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                       SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          style:  TextStyle(fontSize: 10.5, color: Color(0xFF4B5563)),
                          children: [
                             TextSpan(text: 'Sign in code has been sent to '),
                            TextSpan(
                              text: phone.isEmpty ? 'your phone' : phone,
                              style:  TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                             TextSpan(
                                text: ', check your inbox to continue the sign in process.'),
                          ],
                        ),
                      ),
                       SizedBox(height: 16),
                       CodeBoxes(),
                       SizedBox(height: 14),
                       Row(
                        children: [
                          Text("Haven't received the sign in code? ",
                              style: TextStyle(fontSize: 10)),
                          Text('Resend it.',
                              style: TextStyle(fontSize: 10, color: Color(0xFF7A5AF8))),
                        ],
                      ),
                       SizedBox(height: 16),
                      MyButton(
                        text: 'Submit',
                        onPressed: () {
                          currentAccount = findByPhone(phone);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                                (route) => false,
                          );
                        },
                      ),
                       SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text('Sign in with different method ',
                              style: TextStyle(fontSize: 10)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:  Text('Here.',
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF7A5AF8))),
                          ),
                        ],
                      ),
                       SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF7A5AF8),
                borderRadius: BorderRadius.circular(16),
                boxShadow:  [
                  BoxShadow(
                      color: Color(0x557A5AF8), blurRadius: 16, offset: Offset(0, 8)),
                ],
              ),
              child:
              Icon(Icons.phone, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}