import 'package:flutter/material.dart';
import 'sign_up_page.dart';
import 'sign_in_page.dart';
import '../widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 240,
                    ),
                    Image.asset(
                      'assets/images/paw_txt.png',
                      height: 54,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 90),
                    CustomButton(
                      text: 'Sign Up',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      backgroundColor: const Color(0xFFB38E5D),
                      textColor: Colors.white,
                      borderRadius: 50,
                      height: 50,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Log In',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                        );
                      },
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      textColor: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: 50,
                      borderColor: Colors.black,
                      height: 50,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      borderWidth: 2,
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                          children: [
                            const TextSpan(
                                text:
                                    "By tapping 'Create account' or 'Sign in' you agree to our "),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Terms and Conditions tapped')),
                                  );
                                },
                                child: Text(
                                  'Terms and Conditions',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
