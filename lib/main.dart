import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'screens/discover_screen.dart';
import 'screens/setloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
=======
import 'quiz_page1.dart';


void main() {
>>>>>>> 1b5ddccc526016c19f045e2d6d03e04e2e3ca22e
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< HEAD
  const MyApp({super.key});
=======
  const MyApp({Key? key}) : super(key: key);
>>>>>>> 1b5ddccc526016c19f045e2d6d03e04e2e3ca22e

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      title: 'Pet App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const HomeScreen(),
=======
      title: 'Pet Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const QuizPage(),
>>>>>>> 1b5ddccc526016c19f045e2d6d03e04e2e3ca22e
    );
  }
}

<<<<<<< HEAD
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLocationScreen = true;

  void _onLocationSet() {
    setState(() {
      _showLocationScreen = false;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showLocationScreen
          ? SetLocationScreen(onLocationSet: _onLocationSet)
          : DiscoverScreen(),
    );
  }
}
=======
>>>>>>> 1b5ddccc526016c19f045e2d6d03e04e2e3ca22e
