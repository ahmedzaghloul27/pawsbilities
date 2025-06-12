import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'matching_screen.dart';
import 'services/auth_manager.dart';
import 'services/pet_provider.dart';
import 'config/secure_config.dart';
import 'resgisterationScreen/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize secure configuration
  print('🔧 Initializing secure configuration...');
  await SecureConfig.initialize();
  SecureConfig.printConfigStatus();

  // Initialize AuthManager
  final authManager = AuthManager();
  await authManager.initialize();

  runApp(MyApp(authManager: authManager));
}

class MyApp extends StatelessWidget {
  final AuthManager authManager;

  const MyApp({super.key, required this.authManager});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authManager),
        ChangeNotifierProvider(create: (context) => PetProvider()),
      ],
      child: MaterialApp(
        title: 'Pawsibilities',
        theme: AppTheme.theme,
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Load pets after authentication is confirmed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authManager = context.read<AuthManager>();
      if (authManager.isAuthenticated) {
        final petProvider = context.read<PetProvider>();
        petProvider.refreshAllPets();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
      builder: (context, authManager, child) {
        if (authManager.isLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            ),
          );
        }

        if (authManager.isAuthenticated) {
          // Load pets when user is authenticated
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final petProvider = context.read<PetProvider>();
            if (petProvider.userPets.isEmpty &&
                petProvider.availablePets.isEmpty) {
              petProvider.refreshAllPets();
            }
          });

          return const MatchingScreen();
        }

        // Show welcome/login screen if not authenticated
        return const WelcomePage(); // You'll need to create this or use your existing login screen
      },
    );
  }
}
