import 'package:flutter/material.dart';
import 'my_button.dart';
import 'app_image.dart';
import 'signin_page.dart';
import 'signup_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController controller = PageController();
  int currentPage = 0;

  List<String> images = [
    'assets/images/onboard1.png',
    'assets/images/onboard2.png',
    'assets/images/onboard3.png',
    'assets/images/onboard4.png',
  ];

  List<double> imageScales = [1.0, 1.06, 0.82, 1.05];


  List<Offset> imageOffsets = const [
    Offset(-0.06, 0.03),
    Offset(-0.04, 0.06),
    Offset(0.0, 0.0),
    Offset(-0.035, 0.05),
  ];

  List<String> titles = [
    'Welcome to Workmate!',
    'Manage Stress Effectively',
    'Plan for Success',
    'Navigate Your Work Journey\nEfficient & Easy',
  ];

  List<String> texts = [
    'Make Smart Decisions! Set clear timelines for projects and celebrate your achievements!',
    'Stay Balanced! Track your workload and maintain a healthy stress level with ease.',
    'Your Journey Starts Here! Earn achievement badges as you conquer your tasks. Let\'s get started!',
    'Increase your work management & career development radically',
  ];

  @override
  Widget build(BuildContext context) {
    bool isLast = currentPage == 3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: 4,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                Size screen = MediaQuery.of(context).size;
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF7A5AF8), Color(0xFFFFFFFF)],
                            stops: [0.1891, 1.0],
                          ),
                        ),
                        child: SafeArea(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Transform.translate(
                                offset: Offset(
                                  imageOffsets[index].dx * screen.width,
                                  imageOffsets[index].dy * screen.height,
                                ),
                                child: Transform.scale(
                                  scale: imageScales[index],
                                  child: AppImage(
                                    images[index],
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: Column(
                        children: [
                          Text(
                            titles[index],
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                          ),
                           SizedBox(height: 10),
                          Text(
                            texts[index],
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4B5563),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          SizedBox(
            height: 44,
            child: isLast
                ? null
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return AnimatedContainer(
                  duration:  Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 18,
                  height: 4,
                  decoration: BoxDecoration(
                    color: i == currentPage
                        ? const Color(0xFF7A5AF8)
                        : const Color(0xFFE5E1F5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 30),
            child: Column(
              children: [
                MyButton(
                  text: isLast ? 'Sign In' : 'Next',
                  onPressed: () {
                    if (isLast) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInPage()),
                      );
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                MyButton(
                  text: isLast ? 'Sign Up' : 'Skip',
                  filled: false,
                  onPressed: () {
                    if (isLast) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    } else {
                      controller.jumpToPage(3);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}