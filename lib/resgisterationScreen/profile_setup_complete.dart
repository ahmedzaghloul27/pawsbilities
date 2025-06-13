import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'location_enable_page.dart';
import '../widgets/custom_button.dart';
import '../services/auth_manager.dart';
import '../services/api_service.dart';

class ProfileSetupCompletePage extends StatefulWidget {
  final String? firstname;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final String? gender;
  final String? dob;

  const ProfileSetupCompletePage({
    super.key,
    this.firstname,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.gender,
    this.dob,
  });

  @override
  State<ProfileSetupCompletePage> createState() =>
      _ProfileSetupCompletePageState();
}

class _ProfileSetupCompletePageState extends State<ProfileSetupCompletePage> {
  bool _isRegistering = false;

  Future<void> _completeRegistration() async {
    // If we have registration data, register the user automatically
    if (widget.email != null &&
        widget.password != null &&
        widget.firstname != null &&
        widget.lastName != null) {
      setState(() {
        _isRegistering = true;
      });

      final authManager = context.read<AuthManager>();

      try {
        // Step 1: Wake up the backend service (for Render cold start)
        print('🔥 Step 1: Waking up backend...');
        await ApiService.wakeUpBackend();

        // Step 2: Wait a moment for service to be fully ready
        await Future.delayed(const Duration(seconds: 2));

        // Step 3: Attempt registration
        print('📝 Step 2: Attempting registration...');
        final success = await authManager.register(
          firstName: widget.firstname!,
          lastName: widget.lastName!,
          email: widget.email!,
          password: widget.password!,
          phone: widget.phone,
        );

        setState(() {
          _isRegistering = false;
        });

        if (success) {
          // Registration successful, navigate to location enable
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Registration successful! Welcome to Pawsibilities!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LocationEnablePage(),
              ),
            );
          }
        } else {
          // Show detailed error message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Registration failed. This could be because:'),
                    const SizedBox(height: 8),
                    const Text(
                        '• Backend service is starting up (try again in 30s)'),
                    const Text('• Email already exists'),
                    const Text('• Network connection issue'),
                    const SizedBox(height: 8),
                    const Text(
                        'Check the console for detailed error messages.'),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 8),
              ),
            );
          }
        }
      } catch (e) {
        setState(() {
          _isRegistering = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration error: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      }
    } else {
      // No registration data, just navigate to location enable
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LocationEnablePage(),
        ),
      );
    }
  }

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
                      widget.firstname != null && widget.firstname!.isNotEmpty
                          ? 'Congrats, ${widget.firstname}\nYou\'re set to start!'
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
                      text: _isRegistering ? 'REGISTERING...' : 'GET STARTED!',
                      onPressed: _isRegistering
                          ? () {}
                          : () => _completeRegistration(),
                      disabled: _isRegistering,
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
