import 'package:flutter/material.dart';
import 'set_profile_picture_page.dart';
import 'widgets/custom_button.dart';

class VerifyPhonePage extends StatefulWidget {
  final String phoneNumber;
  final String firstName;
  final String lastName;

  const VerifyPhonePage({
    Key? key,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final _formKey = GlobalKey<FormState>();

  // Generate 6 controllers for each digit of the verification code
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onNextPressed() {
    bool isComplete = true;
    String code = '';
    for (var controller in _controllers) {
      final text = controller.text.trim();
      if (text.isEmpty || text.length != 1) {
        isComplete = false;
        break;
      }
      code += text;
    }
    if (!isComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 6 digits')),
      );
      return;
    }
    // If verification code is complete, navigate to SetProfilePicturePage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetProfilePicturePage(
          firstName: widget.firstName,
          lastName: widget.lastName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 16),
              const Text(
                "Enter your code",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.phoneNumber,
                style: const TextStyle(
                    fontSize: 16, color: Colors.black87, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 28),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 44,
                      child: TextFormField(
                        controller: _controllers[index],
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                                color: Color(0xFFB38E5D), width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                                color: Color(0xFFB38E5D), width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                                color: Color(0xFFB38E5D), width: 2),
                          ),
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.length == 1 && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: "Next",
                onPressed: _onNextPressed,
                backgroundColor: const Color(0xFFB38E5D),
                textColor: Colors.white,
                borderRadius: 30,
                height: 50,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
