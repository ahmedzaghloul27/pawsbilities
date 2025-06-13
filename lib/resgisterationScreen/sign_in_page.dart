import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pawsbilities_app/resgisterationScreen/sign_up_page.dart';
import 'forgot_password_page.dart';
import '../widgets/custom_button.dart';
import '../services/auth_manager.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final authManager = context.read<AuthManager>();
      final success = await authManager.login(
        _emailOrPhoneController.text.trim(),
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        // Login successful - AuthWrapper will handle navigation to MatchingScreen
        if (mounted) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      } else {
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed. Please check your credentials.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Your furry friend's world awaits.",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  controller: _emailOrPhoneController,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Email or Phone Number",
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontFamily: 'Poppins'),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFB38E5D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFB38E5D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Color(0xFFB38E5D), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your email or phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontFamily: 'Poppins'),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFB38E5D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFB38E5D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Color(0xFFB38E5D), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                CustomButton(
                  text: _isLoading ? "Signing in..." : "Log in",
                  onPressed: _onLoginPressed,
                  disabled: _isLoading,
                  backgroundColor: const Color(0xFFB38E5D),
                  textColor: Colors.white,
                  borderRadius: 30,
                  height: 50,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 2)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("OR",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black54)),
                    ),
                    const Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 14),
                CustomButton(
                  text: "Continue with Google",
                  onPressed: () {},
                  variant: CustomButtonVariant.outlined,
                  borderColor: Colors.black,
                  borderWidth: 2,
                  borderRadius: 30,
                  height: 50,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  prefixIcon: const Icon(Icons.g_mobiledata,
                      color: Colors.black, size: 28),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 14),
                CustomButton(
                  text: "Continue with Apple",
                  onPressed: () {},
                  variant: CustomButtonVariant.outlined,
                  borderColor: Colors.black,
                  borderWidth: 2,
                  borderRadius: 30,
                  height: 50,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  prefixIcon:
                      const Icon(Icons.apple, color: Colors.black, size: 24),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New to Pawsibilities? ",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Create your account.",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
