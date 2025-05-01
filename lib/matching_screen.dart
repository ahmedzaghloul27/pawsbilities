import 'package:flutter/material.dart';
import 'dart:math';
import 'widgets/custom_nav_bar.dart';
import 'My_profilePage.dart';
import 'community_page.dart';
import 'lost_and_found_page.dart';
import 'discover_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Dog data structure
class Dog {
  final String name;
  final String imageUrl;

  Dog({required this.name, required this.imageUrl});
}

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  int _selectedIndex = 2; // Matching screen is index 2 (paw button)
  final String userName = 'Ahmed'; // Variable for user name
  bool _isAdopting = false; // Toggle state for adopting button

  // List of available dogs
  final List<Dog> _dogs = [
    Dog(name: 'Leo', imageUrl: 'assets/images/dog.png'),
    Dog(name: 'Max', imageUrl: 'assets/images/dog2.jpg'),
    Dog(name: 'Fluffy', imageUrl: 'assets/images/dog3.jpg'),
    Dog(name: 'Bondok', imageUrl: 'assets/images/dog4.jpg'),
  ];

  // Currently selected dog
  late Dog _selectedDog;

  @override
  void initState() {
    super.initState();
    _selectedDog = _dogs[0]; // Initialize with Leo
  }

  // Show dog selection dialog
  void _showDogSelection(BuildContext context) {
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
                    'Select a Dog',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    _dogs.length,
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
                              _selectedDog = _dogs[index];
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
                                  backgroundImage:
                                      AssetImage(_dogs[index].imageUrl),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  _dogs[index].name,
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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 23,
                        backgroundImage:
                            const AssetImage('assets/images/Profile_pic.jpg'),
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
                                text: '$userName!',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: const [
                            Text(
                              'Alexandria, Miami',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
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
                    icon: SvgPicture.asset(
                      'assets/icons/Bell_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/Chat_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Add some spacing after the header
            // Title and Adopting button row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top picks for ${_selectedDog.name}',
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
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _isAdopting ? Colors.black : Colors.transparent,
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
                          color: _isAdopting ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 460,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(top: 8, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                border: Border.all(
                  color: const Color(0xFFCBCBCB),
                  width: 2,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFE2B4),
                    Color(0xFFEEC481),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image container
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      image: const DecorationImage(
                        image:
                            AssetImage('assets/images/matchscreen_design.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Exploring friends text
                  const Text(
                    'Exploring friends for:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  // Leo dropdown button
                  GestureDetector(
                    onTap: () => _showDogSelection(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(_selectedDog.imageUrl),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _selectedDog.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 28,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Start button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
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
