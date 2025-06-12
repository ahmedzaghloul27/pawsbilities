import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/small_pet_card.dart';
import 'My_profilePage.dart';
import 'community_page.dart';
import 'lost_and_found_page.dart';
import 'discover_page.dart';
import 'matches_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Notifications.dart';
import 'set_location_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'dart:math' as math;
import 'chat_page.dart';
import 'services/auth_manager.dart';
import 'services/pet_provider.dart';
import 'models/pet_model.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 2; // Matching screen is index 2 (paw button)
  bool _isAdopting = false; // Toggle state for adopting button
  bool _isLikedProfilesTab = true; // Add this to track active tab

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  // Selected pet from user's pets (for non-adopting mode)
  Pet? _selectedUserPet;

  String? _currentLocationName;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationName();

    // Initialize flip animation
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOut,
    ));

    // Load data after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final petProvider = context.read<PetProvider>();
      final authManager = context.read<AuthManager>();

      if (authManager.isAuthenticated) {
        // Load pets if not already loaded
        if (petProvider.userPets.isEmpty && petProvider.availablePets.isEmpty) {
          petProvider.refreshAllPets();
        }

        // Set default selected pet
        if (petProvider.userPets.isNotEmpty && _selectedUserPet == null) {
          setState(() {
            _selectedUserPet = petProvider.userPets.first;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocationName() async {
    try {
      // Use geolocator to get current position
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // Use GooglePlace to reverse geocode
      final googlePlace =
          GooglePlace('AIzaSyD4JvQ5V1FZHEAtCluWpb8l0y3o-PJS7K8');
      final response = await googlePlace.search.getNearBySearch(
        Location(lat: position.latitude, lng: position.longitude),
        1,
      );
      String name = 'Current Location';
      if (response != null &&
          response.results != null &&
          response.results!.isNotEmpty) {
        name = response.results!.first.name ?? name;
      }
      if (mounted) {
        setState(() {
          _currentLocationName = name;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _currentLocationName = 'Current Location';
        });
      }
    }
  }

  // Show pet selection dialog
  void _showPetSelection(BuildContext context) {
    final petProvider = context.read<PetProvider>();

    if (petProvider.userPets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need to add a pet first!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: 280,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select a Pet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    petProvider.userPets.length,
                    (index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (index > 0)
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFE0E0E0),
                            indent: 0,
                            endIndent: 0,
                          ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedUserPet = petProvider.userPets[index];
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: petProvider
                                          .userPets[index].imageUrl
                                          .startsWith('http')
                                      ? NetworkImage(
                                          petProvider.userPets[index].imageUrl)
                                      : AssetImage(petProvider.userPets[index]
                                          .imageUrl) as ImageProvider,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  petProvider.userPets[index].name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
    return Consumer2<AuthManager, PetProvider>(
      builder: (context, authManager, petProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                // Sticky Header
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  expandedHeight: 0,
                  toolbarHeight: 80,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 23,
                                backgroundImage:
                                    authManager.currentUser?.profileImageUrl !=
                                            null
                                        ? NetworkImage(authManager
                                            .currentUser!.profileImageUrl!)
                                        : const AssetImage(
                                                'assets/images/Profile_pic.jpg')
                                            as ImageProvider,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Hi ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${authManager.userName}!',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SetLocationPage(),
                                          ),
                                        );
                                        if (result != null &&
                                            result is Map &&
                                            result['name'] != null) {
                                          setState(() {
                                            _currentLocationName =
                                                result['name'];
                                          });
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            authManager.currentUser?.location ??
                                                _currentLocationName ??
                                                'Detecting location...',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 18,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/Bell_icon.svg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Notifications_AppPage(),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/Chat_icon.svg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChatPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      // Title and Adopting button row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _isAdopting
                                  ? 'Top picks for you'
                                  : 'Top picks for ${_selectedUserPet?.name ?? 'your pet'}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isAdopting = !_isAdopting;
                                });
                                // Trigger flip animation
                                if (_isAdopting) {
                                  _flipController.forward();
                                } else {
                                  _flipController.reverse();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _isAdopting
                                      ? Colors.black
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 9, 9, 9),
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  'Adopting',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _isAdopting
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Exploring container with flip animation
                      AnimatedBuilder(
                        animation: _flipAnimation,
                        builder: (context, child) {
                          final isShowingFront = _flipAnimation.value < 0.5;
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_flipAnimation.value * math.pi),
                            child: Container(
                              height: 460,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(29),
                                border: Border.all(
                                  color: const Color(0xFFCBCBCB),
                                  width: 2,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: _isAdopting
                                      ? [
                                          const Color(0xFFFFB84D), // Orange
                                          const Color(
                                              0xFFFF8C42), // Darker orange
                                        ]
                                      : [
                                          const Color(
                                              0xFFFFE2B4), // Light yellow
                                          const Color(
                                              0xFFEEC481), // Darker yellow
                                        ],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.09),
                                    offset: Offset(1, 4),
                                    blurRadius: 8.1,
                                  ),
                                ],
                              ),
                              child: isShowingFront
                                  ? _buildFrontContent(petProvider)
                                  : Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..rotateY(math.pi),
                                      child: _buildBackContent(petProvider),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
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

  Widget _buildFrontContent(PetProvider petProvider) {
    // Display appropriate pets based on mode
    final pets =
        _isAdopting ? petProvider.availablePets : petProvider.availablePets;

    if (petProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (pets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pets,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _isAdopting
                  ? 'No pets available for adoption'
                  : 'No matches found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    // Show first available pet for simplicity
    final pet = pets.first;

    return _buildPetCard(pet);
  }

  Widget _buildBackContent(PetProvider petProvider) {
    return _buildFrontContent(petProvider); // For now, same content
  }

  Widget _buildPetCard(Pet pet) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Pet image
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: pet.imageUrl.startsWith('http')
                      ? NetworkImage(pet.imageUrl)
                      : AssetImage(pet.imageUrl) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            // Pet info
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${pet.breed} • ${pet.age}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  if (pet.description != null && pet.description!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        pet.description!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            // Selection button (if not in adopting mode)
            if (!_isAdopting && _selectedUserPet != null)
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () => _showPetSelection(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage:
                              _selectedUserPet!.imageUrl.startsWith('http')
                                  ? NetworkImage(_selectedUserPet!.imageUrl)
                                  : AssetImage(_selectedUserPet!.imageUrl)
                                      as ImageProvider,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _selectedUserPet!.name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
