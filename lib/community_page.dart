import 'package:flutter/material.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/sticky_header.dart';
import 'widgets/post_widget.dart';
import 'lost_and_found_page.dart';
import 'matching_screen.dart';
import 'discover_page.dart';
import 'My_profilePage.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on community page
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DiscoverPage()),
        );
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
              flexibleSpace: const StickyHeader(
                title: 'Community',
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  PostWidget(
                    profileImageUrl:
                        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    userName: 'Rich Froning',
                    timeAgo: '11m',
                    content:
                        'My pup has been lonely up until now so we\'d love for him to make new friends and socialize❤️‼️',
                    imageUrl: 'https://i.imgur.com/tGbaZCY.jpg',
                    likesCount: 12,
                    commentsCount: 1,
                    onLikePressed: () {},
                    onCommentPressed: () {},
                    onSharePressed: () {},
                    onMorePressed: () {},
                  ),
                  const SizedBox(height: 16),
                ]),
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
