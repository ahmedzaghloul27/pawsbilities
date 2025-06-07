import 'package:flutter/material.dart';
import 'dart:ui'; // Add this import for ImageFilter
import 'dart:io';
import 'package:pawsbilities_app/matching_screen.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/sticky_header.dart';
import 'widgets/post_widget.dart';
import 'widgets/my_pet_profile_card.dart';
import 'settings.dart';
import 'community_page.dart';
import 'lost_and_found_page.dart';
import 'discover_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'constants/colors.dart';
import 'edit_profile_page.dart';
import 'user_data.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  int _selectedIndex = 4;
  bool _isPetEditMode = false;
  List<Map<String, dynamic>> _pets = [
    {
      'imageUrl': 'assets/images/dog.png',
      'additionalImages': ['assets/images/dog2.jpg', 'assets/images/dog3.jpg'],
      'name': 'Buddy',
      'breed': 'Golden Retriever',
      'age': '3 years',
      'weight': '30 kg',
      'distance': 3.5,
      'isFemale': false,
      'personality': 'Friendly, Energetic, Loyal',
      'description':
          'Buddy is a loving golden retriever who enjoys playing fetch and swimming. He\'s great with kids and other pets!',
    },
    {
      'imageUrl': 'assets/images/dog2.jpg',
      'additionalImages': ['assets/images/dog4.jpg'],
      'name': 'Luna',
      'breed': 'Border Collie',
      'age': '2 years',
      'weight': '22 kg',
      'distance': 2.8,
      'isFemale': true,
      'personality': 'Intelligent, Active, Protective',
      'description':
          'Luna is a smart and agile border collie who loves to learn new tricks and go on adventures. Very protective of her family.',
    },
  ];

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

  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentFirstName: UserData.firstName,
          currentLastName: UserData.lastName,
          currentEmail: UserData.email,
          currentBio: UserData.bio,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        UserData.updateProfile(
          firstName: result['firstName'],
          lastName: result['lastName'],
          bio: result['bio'],
          profileImage: result['profileImage'],
        );
      });
    }
  }

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
            // Only allow pop if card is not flipped
            if (controller.state?.isFront ?? true) {
              return true;
            } else {
              controller.toggleCard();
              return false;
            }
          },
          child: GestureDetector(
            onTap: () {
              // Only close if card is not flipped
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
                      ownerImageUrl: 'assets/images/Profile_pic.jpg',
                      isOnline: true,
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
                              backgroundImage: UserData.profileImage != null
                                  ? FileImage(UserData.profileImage!)
                                  : const AssetImage(
                                          'assets/images/Profile_pic.jpg')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                UserData.fullName,
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
                                      Text(
                                        '📍',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 5),
                                      Icon(Icons.circle,
                                          color: Colors.green, size: 10),
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
                                UserData.bio,
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

                    // Edit Button
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _navigateToEditProfile,
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
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Pets
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pets',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Poppins',
                            fontSize: 22,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isPetEditMode = !_isPetEditMode;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ..._pets.map((pet) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: _isPetEditMode
                                        ? null
                                        : () => _showPetDetails(pet),
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
                                  if (_isPetEditMode)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _pets.remove(pet);
                                          });
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 237, 237, 237),
                              border: Border.all(
                                  color: AppColors.primary, width: 3),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.add_rounded,
                                  color: AppColors.primary, size: 50),
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
                    PostWidget(
                      profileImageUrl: UserData.profileImage != null
                          ? UserData.profileImage!.path
                          : 'assets/images/Profile_pic.jpg',
                      userName: UserData.fullName,
                      timeAgo: '11m',
                      content:
                          'My pup has been lonely up until now so we\'d love for him to make new friends and socialize❤️‼️',
                      imageUrl: 'assets/images/dog.png',
                      likesCount: 12,
                      commentsCount: 1,
                      onLikePressed: () {},
                      onCommentPressed: () {},
                      onSharePressed: () {},
                      onMorePressed: () {},
                    ),
                    const SizedBox(height: 16),
                    PostWidget(
                      profileImageUrl: UserData.profileImage != null
                          ? UserData.profileImage!.path
                          : 'assets/images/Profile_pic.jpg',
                      userName: UserData.fullName,
                      timeAgo: '2h',
                      content:
                          'Just completed our first training session! So proud of how well my pup did today 🎓🐕',
                      imageUrl: 'assets/images/dog2.jpg',
                      likesCount: 156,
                      commentsCount: 42,
                      onLikePressed: () {},
                      onCommentPressed: () {},
                      onSharePressed: () {},
                      onMorePressed: () {},
                    ),
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
