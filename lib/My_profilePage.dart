import 'package:flutter/material.dart';
import 'dart:ui'; // Add this import for ImageFilter
import 'package:pawsbilities_app/matching_screen.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/sticky_header.dart';
import 'settings.dart';
import 'community_page.dart';
import 'lost_and_found_page.dart';
import 'discover_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants/colors.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  int _selectedIndex = 4;

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DiscoverPage()),
        );
        break;
      case 4:
        // Already on profile page
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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: false,
              expandedHeight: 77,
              flexibleSpace: StickyHeader(
                title: 'My Profile',
                trailing: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/settings_icon.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Profile Info
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 51,
                              backgroundImage: const AssetImage(
                                  'assets/images/Profile_pic.jpg'),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mohammed Osama',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '📍',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 5),
                                      Icon(Icons.circle,
                                          color:  Colors.green, size: 10),
                                    ],
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mandara, Alexandria',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Last active in 3 days',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                "I'm a software engineer and happy to be here on the app",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Edit Button
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB88C59),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Edit my profile',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 237, 237),
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Pets
                    const Text(
                      'Pets',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...[
                            'https://images.unsplash.com/photo-1453487977089-77350a275ec5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nJTIwYnJlZWRzfGVufDB8fDB8fHww',
                            'https://www.princeton.edu/sites/default/files/styles/1x_full_2x_half_crop/public/images/2022/02/KOA_Nassau_2697x1517.jpg?itok=Bg2K7j7J',
                            'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?q=80&w=1988&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ].map((url) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(url),
                              ),
                            );
                          }),
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primary, width: 2),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.add,
                                  color: AppColors.primary, size: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Posts
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Row(
                        children: [
                          Text(
                            'Posts',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const PostCard(),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const PostCard(),
                    ),
                    const SizedBox(height: 16),
                  ],
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

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/Profile_pic.jpg'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ahmed Zaghloul',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '11m',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(height: 12),
          // Post Content
          const Text(
            'My pup has been lonely up until now so we\'d love for him to make new friends and socialize❤️‼️',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          // Post Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://i.imgur.com/tGbaZCY.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Post Actions
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border,
                        size: 20, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '12',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Icon(Icons.chat_bubble_outline,
                        size: 20, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '1',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.share, size: 20, color: Colors.grey[600]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
