import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(77, 0, 0, 0), // ~30% opacity black
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a chat...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey.shade600,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
