import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFFB88C59),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB88C59),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
