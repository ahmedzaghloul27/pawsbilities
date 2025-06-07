import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'matching_screen.dart';
import 'services/mongo_service.dart';
import 'services/auth_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize MongoDB connection
  try {
    await MongoService.connect();
    print('🚀 App started with MongoDB connection');
  } catch (e) {
    print('⚠️ App started without MongoDB connection: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthManager(),
      child: MaterialApp(
        title: 'Pawsibilities',
        theme: AppTheme.theme,
        home: const MatchingScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
