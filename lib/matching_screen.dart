import 'package:flutter/material.dart';
import 'widgets/custom_nav_bar.dart';
import 'My_profilePage.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  int _selectedIndex = 2; // Matching screen is index 2 (paw button)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        // Already on matching screen
        break;
      case 3:
        Navigator.pushNamed(context, '/explore');
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/32.jpg',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hi Ahmed!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: const [
                            Text(
                              'Alexandria, Miami',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.notifications_none_rounded, size: 26),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.chat_bubble_outline_rounded, size: 26),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // You can add more widgets below if needed
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
