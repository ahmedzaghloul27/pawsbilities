import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'My_profilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawsibilities',
      theme: AppTheme.theme,
      home: const MyProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
