import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

class DogProfileCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String breed;
  final String age;
  final String weight;
  final double distance;
  final String ownerImageUrl;
  final bool isOnline;
  final bool isFemale;
  final VoidCallback onLike;
  final VoidCallback onChat;
  final VoidCallback onMore;

  const DogProfileCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.breed,
    required this.age,
    required this.weight,
    required this.distance,
    required this.ownerImageUrl,
    required this.isOnline,
    required this.isFemale,
    required this.onLike,
    required this.onChat,
    required this.onMore,
  });

  @override
  State<DogProfileCard> createState() => _DogProfileCardState();
}

class _DogProfileCardState extends State<DogProfileCard> {
  late FlipCardController _flipCardController;

  String _convertKgToLbs(String kg) {
    try {
      double kgValue = double.parse(kg.replaceAll(' kg', ''));
      double lbsValue = kgValue * 2.20462;
      return '${kgValue.toStringAsFixed(1)} kg / ${lbsValue.toStringAsFixed(1)} lbs';
    } catch (e) {
      return kg;
    }
  }

  @override
  void initState() {
    super.initState();
    _flipCardController = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: _flipCardController,
      flipOnTouch: false,
      front: _buildFrontCard(),
      back: _buildBackCard(),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Profile image
            Image.asset(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color.fromRGBO(0, 0, 0, 0.62),
                    Color.fromRGBO(0, 0, 0, 0.84),
                  ],
                  stops: [0.0, 0.55, 0.72, 0.92],
                ),
              ),
            ),

            // Content overlay
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User profile at top left
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: CircleAvatar(
                              radius: 26,
                              backgroundImage: AssetImage(widget.ownerImageUrl),
                            ),
                          ),
                          if (widget.isOnline)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Bottom info section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and gender
                      Row(
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            widget.isFemale ? Icons.female : Icons.male,
                            color: Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Breed
                      Text(
                        widget.breed,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Age and weight
                      Text(
                        '${widget.age} / ${_convertKgToLbs(widget.weight)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action buttons on right
            Positioned(
              right: 20,
              bottom: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    color: Colors.white,
                    iconSize: 28,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _flipCardController.toggleCard();
                      widget.onMore();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5E9), // Light beige background
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with close button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Petfile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _flipCardController.toggleCard(),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More about "${widget.name}"',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Dog details
                  Row(
                    children: [
                      const Text('🐶', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        widget.breed,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Text('🎂', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        widget.age,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Text('🐕', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        _convertKgToLbs(widget.weight),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // I'm usually section
                  const Text(
                    "I'm usually..",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Traits chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTraitChip('hyper-active'),
                      _buildTraitChip('Friendly'),
                      _buildTraitChip('High energy'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Fixed bottom section with owner info
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(widget.ownerImageUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jana Soliman',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.location_on, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'Smouha, Alexandria Egypt',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side:
                                const BorderSide(color: Colors.black, width: 2),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'View Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTraitChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }
}
