import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'widgets/custom_nav_bar.dart';
import 'widgets/sticky_header.dart';
import 'widgets/three_item_header.dart';
import 'widgets/post_widget.dart';
import 'widgets/my_pet_profile_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'constants/colors.dart';
import 'chat_page.dart';
import 'individual_chat_page.dart';
import 'community_page.dart';
import 'lost_and_found_page.dart';
import 'matching_screen.dart';
import 'discover_page.dart';
import 'My_profilePage.dart';

class UserProfilePage extends StatefulWidget {
  final String userName;
  final String userLocation;
  final String userBio;
  final String? userImagePath;
  final String lastActive;
  final bool isOnline;
  final List<Map<String, dynamic>> userPets;
  final List<Map<String, dynamic>> userPosts;

  const UserProfilePage({
    super.key,
    required this.userName,
    required this.userLocation,
    required this.userBio,
    this.userImagePath,
    required this.lastActive,
    this.isOnline = false,
    this.userPets = const [],
    this.userPosts = const [],
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _isPetEditMode = false;

  void _showPetDetails(Map<String, dynamic> pet) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.85;
    final cardHeight = size.height * 0.7;
    final controller = FlipCardController();

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.state?.isFront ?? true) {
              return true;
            } else {
              controller.toggleCard();
              return false;
            }
          },
          child: GestureDetector(
            onTap: () {
              if (controller.state?.isFront ?? true) {
                Navigator.of(context).pop();
              }
            },
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: DogProfileCard(
                      imageUrl: pet['imageUrl'],
                      name: pet['name'],
                      breed: pet['breed'],
                      age: pet['age'],
                      weight: pet['weight'],
                      distance: pet['distance'],
                      ownerImageUrl: widget.userImagePath ??
                          'assets/images/Profile_pic.jpg',
                      isOnline: widget.isOnline,
                      isFemale: pet['isFemale'],
                      onLike: () {},
                      onChat: () {},
                      onMore: () {
                        controller.toggleCard();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.report_outlined),
                title: const Text('Report User'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle report functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.block_outlined),
                title: const Text('Block User'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle block functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Share Profile'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle share functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IndividualChatPage(
          name: widget.userName,
          profileImage: widget.userImagePath,
        ),
      ),
    );
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
              expandedHeight: 80,
              automaticallyImplyLeading: false,
              flexibleSpace: ThreeItemHeader(
                title: 'Profile',
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert,
                      color: Colors.black, size: 28),
                  onPressed: _showMoreOptions,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                            boxShadow: [
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
                              backgroundImage: widget.userImagePath != null
                                  ? (widget.userImagePath!.startsWith('assets/')
                                          ? AssetImage(widget.userImagePath!)
                                          : FileImage(
                                              File(widget.userImagePath!)))
                                      as ImageProvider
                                  : const AssetImage(
                                      'assets/images/Profile_pic.jpg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userName,
                                style: const TextStyle(
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
                                      const Text(
                                        '📍',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 5),
                                      Icon(
                                        Icons.circle,
                                        color: widget.isOnline
                                            ? Colors.green
                                            : Colors.grey,
                                        size: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 2),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.userLocation,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          widget.lastActive,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                widget.userBio,
                                style: const TextStyle(
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

                    // Send Message Button
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Send Message',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Pets Section
                    const Text(
                      'Pets',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Pets Grid or Scroll View
                    if (widget.userPets.isEmpty)
                      Container(
                        height: 120,
                        child: const Center(
                          child: Text(
                            'No pets to show',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      )
                    else
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: widget.userPets.map((pet) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () => _showPetDetails(pet),
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primary, width: 3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 42,
                                    backgroundImage:
                                        AssetImage(pet['imageUrl']),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    const SizedBox(height: 30),

                    // Posts Section
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'Posts',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Posts List or Empty State
                    if (widget.userPosts.isEmpty)
                      Container(
                        height: 100,
                        child: const Center(
                          child: Text(
                            'No posts yet',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      )
                    else
                      ...widget.userPosts.map((post) => Column(
                            children: [
                              PostWidget(
                                profileImageUrl: widget.userImagePath ??
                                    'assets/images/Profile_pic.jpg',
                                userName: widget.userName,
                                timeAgo: post['timeAgo'] ?? '1h',
                                content: post['content'] ?? '',
                                imageUrl: post['imageUrl'],
                                likesCount: post['likesCount'] ?? 0,
                                commentsCount: post['commentsCount'] ?? 0,
                                onLikePressed: () {},
                                onCommentPressed: () {},
                                onSharePressed: () {},
                                onMorePressed: () {},
                              ),
                              const SizedBox(height: 16),
                            ],
                          )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex:
            -1, // No item selected since this is a separate profile page
        onItemTapped: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    // Import the necessary pages
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CommunityPage()),
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LostAndFoundPage()),
          (route) => false,
        );
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MatchingScreen()),
          (route) => false,
        );
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DiscoverPage()),
          (route) => false,
        );
        break;
      case 4:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyProfilePage()),
          (route) => false,
        );
        break;
    }
  }
}
