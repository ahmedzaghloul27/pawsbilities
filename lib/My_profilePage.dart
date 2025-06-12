import 'package:flutter/material.dart';
import 'dart:ui'; // Add this import for ImageFilter
import 'dart:io';
import 'package:provider/provider.dart';
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
import 'services/auth_manager.dart';
import 'services/pet_provider.dart';
import 'models/pet_model.dart';
import 'resgisterationScreen/set_pet_pictures_page.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  int _selectedIndex = 4;
  bool _isPetEditMode = false;

  @override
  void initState() {
    super.initState();
    // Load user pets when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final petProvider = context.read<PetProvider>();
      final authManager = context.read<AuthManager>();

      if (authManager.isAuthenticated) {
        // Refresh pets if they haven't been loaded
        if (petProvider.userPets.isEmpty) {
          petProvider.loadUserPets();
        }
      }
    });
  }

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
    final authManager = context.read<AuthManager>();
    final currentUser = authManager.currentUser;

    if (currentUser == null) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentFirstName: currentUser.firstName,
          currentLastName: currentUser.lastName,
          currentEmail: currentUser.email,
          currentBio: currentUser.bio ?? '',
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      // Update profile via UserData which uses AuthManager
      await UserData.updateProfile(
        firstName: result['firstName'],
        lastName: result['lastName'],
        bio: result['bio'],
        profileImage: result['profileImage'],
      );
    }
  }

  Future<void> _navigateToAddPet() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetPetPicturesPage(isFromProfile: true),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      final petProvider = context.read<PetProvider>();
      final authManager = context.read<AuthManager>();

      if (authManager.userId != null) {
        // Create pet data
        final petData = {
          'name': result['name'],
          'breed': result['breed'],
          'age': result['age'],
          'weight': result['weight'],
          'isFemale': result['gender'] == 'Female',
          'imageUrl': result['mainImage'], // This should be handled by backend
          'additionalImages': result['additionalImages'] ?? [],
          'personality': 'Friendly, Playful',
          'description': 'A lovely pet looking for friends!',
          'ownerId': authManager.userId,
          'isAvailable': true,
        };

        // Add pet via PetProvider
        final success = await petProvider.addPet(petData);

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pet added successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Failed to add pet: ${petProvider.error ?? 'Unknown error'}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _deletePet(Pet pet) async {
    if (pet.id == null) return;

    final petProvider = context.read<PetProvider>();
    final success = await petProvider.removePet(pet.id!);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pet removed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to remove pet: ${petProvider.error ?? 'Unknown error'}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPetDetails(Pet pet) {
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
                      imageUrl: pet.imageUrl,
                      name: pet.name,
                      breed: pet.breed,
                      age: pet.age,
                      weight: pet.weight,
                      distance: 0.0, // Calculate if needed
                      ownerImageUrl: context
                              .read<AuthManager>()
                              .currentUser
                              ?.profileImageUrl ??
                          'assets/images/Profile_pic.jpg',
                      isOnline: true,
                      isFemale: pet.isFemale,
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
    return Consumer2<AuthManager, PetProvider>(
      builder: (context, authManager, petProvider, child) {
        final currentUser = authManager.currentUser;

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
                                  backgroundImage:
                                      _getProfileImage(currentUser),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentUser?.fullName ?? 'Unknown User',
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
                                              color: authManager.isAuthenticated
                                                  ? Colors.green
                                                  : Colors.grey,
                                              size: 10),
                                        ],
                                      ),
                                      SizedBox(width: 2),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentUser?.location ??
                                                  'Location not set',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              authManager.isAuthenticated
                                                  ? 'Online'
                                                  : 'Offline',
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
                                    currentUser?.bio ??
                                        'Welcome to Pawsibilities!',
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
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

                        // Pets Display
                        if (petProvider.isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (petProvider.error != null)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Error loading pets: ${petProvider.error}',
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => petProvider.loadUserPets(),
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...petProvider.userPets.map((pet) {
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
                                                  color: AppColors.primary,
                                                  width: 3),
                                              shape: BoxShape.circle,
                                            ),
                                            child: CircleAvatar(
                                              radius: 42,
                                              backgroundImage:
                                                  _getPetImage(pet),
                                            ),
                                          ),
                                        ),
                                        if (_isPetEditMode)
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () => _deletePet(pet),
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
                                GestureDetector(
                                  onTap: _navigateToAddPet,
                                  child: Container(
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
                        // Posts would be loaded from backend here
                        Center(
                          child: Text(
                            'No posts yet',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
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
      },
    );
  }

  ImageProvider _getProfileImage(dynamic user) {
    // Try to get profile image from UserData first (local file)
    if (UserData.profileImage != null) {
      return FileImage(UserData.profileImage!);
    }

    // Then try user's profile image URL
    if (user?.profileImageUrl != null && user.profileImageUrl.isNotEmpty) {
      return NetworkImage(user.profileImageUrl);
    }

    // Fallback to default asset
    return const AssetImage('assets/images/Profile_pic.jpg');
  }

  ImageProvider _getPetImage(Pet pet) {
    if (pet.imageUrl.startsWith('http')) {
      return NetworkImage(pet.imageUrl);
    } else {
      return AssetImage(pet.imageUrl);
    }
  }
}
