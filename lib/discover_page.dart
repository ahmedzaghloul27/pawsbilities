import 'package:flutter/material.dart';
import 'widgets/custom_nav_bar.dart';
import 'community_page.dart';
import 'lost_and_found_page.dart';
import 'matching_screen.dart';
import 'My_profilePage.dart';
import 'widgets/sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CommunityPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LostAndFoundPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MatchingScreen()),
        );
        break;
      case 3:
        // Already on discover page
        break;
      case 4:
        Navigator.pushReplacement(
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
      extendBody: false,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: false,
              expandedHeight: 77,
              flexibleSpace: StickyHeader(
                title: 'Discover',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/Bell_icon.svg',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        // TODO: Navigate to notifications screen
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/Chat_icon.svg',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        // TODO: Navigate to chat screen
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'Discover Page Content',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
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
