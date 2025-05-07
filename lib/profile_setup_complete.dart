import 'package:flutter/material.dart';
import 'location_enable_page.dart';
import 'widgets/custom_button.dart';

class ProfileSetupCompletePage extends StatelessWidget {
  final String? firstname;
  const ProfileSetupCompletePage({super.key, this.firstname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDD8849),
      body: Stack(
        children: [
          // Confetti background (if available)
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          color: Color(0xFFFFA76B), size: 36),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Profile Set Up!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      firstname != null && firstname!.isNotEmpty
                          ? 'Congrats, $firstname\nYou\'re set to start!'
                          : 'Congrats\nYou\'re set to start!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Thank you for choosing Pawsibilities!\nLet\'s make tails wag',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: 'GET STARTED!',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationEnablePage(),
                          ),
                        );
                      },
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      borderRadius: 30,
                      height: 50,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
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
