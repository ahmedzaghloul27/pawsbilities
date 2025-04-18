import 'package:flutter/material.dart';
import 'package:pawsbilities_app/settings.dart';
import 'package:pawsbilities_app/welcome_page.dart';
import 'My_profilePage.dart';
import 'Notifications.dart';
import 'SetPetProfilePage.dart';
import 'sign_up_page.dart';
import 'sign_in_page.dart';
import 'forgot_password_page.dart';
import 'set_new_password_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyProfilePage(),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/forgot': (context) => const ForgotPasswordPage(),
        '/setnewpassword': (context) => const SetNewPasswordPage(),
      },
    );
  }
}
