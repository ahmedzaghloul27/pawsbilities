// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pawsbilities_app/main.dart';
import 'package:pawsbilities_app/services/auth_manager.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Create an AuthManager instance for testing
    final authManager = AuthManager();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(authManager: authManager));

    // Verify that our app loads (we expect the welcome page to be shown for unauthenticated users)
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });
}
