import 'package:flutter/material.dart';
import 'package:pet_menu_bar/widgets/custom_bottom_navbar.dart'; // Import your bottom nav


class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important! Allows bottom nav bar to float over body
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Map Background (b3den hnhot google maps api)
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
            ),
          ),

          // Floating Top Bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discover',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications_none, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Filters
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  filterChip("All", selected: false),
                  filterChip("Stores"),
                  filterChip("Shelters"),
                  filterChip("Vets"),
                ],
              ),
            ),
          ),

          // Bottom Navigation Bar (floating)
          Positioned(
            left: 0,
            right: 0,
            bottom: 10, // Slightly up from bottom
            child: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget filterChip(String label, {bool selected = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
