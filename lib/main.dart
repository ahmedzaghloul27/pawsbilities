import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'matching_screen.dart';

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
      home: const MatchingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
