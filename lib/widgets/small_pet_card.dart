import 'package:flutter/material.dart';
import 'my_pet_profile_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

class SmallPetCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String breed;
  final String age;
  final String weight;
  final double distance;
  final bool isFemale;
  final VoidCallback onTap;
  final bool showGender;

  const SmallPetCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.breed,
    required this.age,
    required this.weight,
    required this.distance,
    required this.isFemale,
    required this.onTap,
    this.showGender = true,
  });

  void _showProfileOverlay(BuildContext context) {
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
                // Prevent taps from propagating to the outer GestureDetector
                onTap: () {},
                child: Center(
                  child: SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: DogProfileCard(
                      imageUrl: imageUrl,
                      name: name,
                      breed: breed,
                      age: age,
                      weight: weight,
                      distance: distance,
                      ownerImageUrl: 'assets/images/Profile_pic.jpg',
                      isOnline: true,
                      isFemale: isFemale,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.62),
                      Colors.black.withOpacity(0.84),
                    ],
                    stops: const [0.0, 0.55, 0.72, 0.92],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and gender
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (showGender) ...[
                          const SizedBox(width: 4),
                          Icon(
                            isFemale ? Icons.female : Icons.male,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    // Breed
                    Text(
                      breed,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
  }
}
