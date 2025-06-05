import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/dog_profile_card_overlay.dart';
import 'widgets/custom_button.dart';
import 'chat_page.dart';

class Dog {
  final String imageUrl;
  final List<String> additionalImages;
  final String name;
  final String breed;
  final String age;
  final String weight;
  final double distance;
  final String ownerImageUrl;
  final bool isOnline;
  final bool isFemale;

  Dog({
    required this.imageUrl,
    this.additionalImages = const [],
    required this.name,
    required this.breed,
    required this.age,
    required this.weight,
    required this.distance,
    required this.ownerImageUrl,
    required this.isOnline,
    required this.isFemale,
  });
}

class MatchesPage extends StatefulWidget {
  final String selectedDogName;
  final String selectedDogImageUrl;
  final bool isAdopting;

  const MatchesPage({
    super.key,
    required this.selectedDogName,
    required this.selectedDogImageUrl,
    required this.isAdopting,
  });

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  late CardSwiperController _swiperController;
  int _currentIndex = 0;
  bool _isFinished = false;

  final List<Dog> _dogs = [
    Dog(
      imageUrl: 'assets/images/dog.png',
      additionalImages: [
        'assets/images/dog2.jpg',
        'assets/images/dog3.jpg',
        'assets/images/dog4.jpg'
      ],
      name: 'Luna',
      breed: 'Golden Retriever',
      age: '2 years',
      weight: '25 kg',
      distance: 3.0,
      ownerImageUrl: 'assets/images/Profile_pic.jpg',
      isOnline: true,
      isFemale: true,
    ),
    Dog(
      imageUrl: 'assets/images/dog2.jpg',
      additionalImages: ['assets/images/dog.png', 'assets/images/dog4.jpg'],
      name: 'Max',
      breed: 'Labrador',
      age: '1.5 years',
      weight: '22 kg',
      distance: 4.2,
      ownerImageUrl: 'assets/images/Profile_pic.jpg',
      isOnline: false,
      isFemale: false,
    ),
    Dog(
      imageUrl: 'assets/images/dog3.jpg',
      additionalImages: ['assets/images/dog.png', 'assets/images/dog2.jpg'],
      name: 'Bella',
      breed: 'Poodle',
      age: '10 months',
      weight: '5 kg',
      distance: 2.8,
      ownerImageUrl: 'assets/images/Profile_pic.jpg',
      isOnline: true,
      isFemale: true,
    ),
    Dog(
      imageUrl: 'assets/images/dog4.jpg',
      additionalImages: ['assets/images/dog2.jpg', 'assets/images/dog3.jpg'],
      name: 'Bondok',
      breed: 'German Shepherd',
      age: '3 years',
      weight: '32 kg',
      distance: 5.0,
      ownerImageUrl: 'assets/images/Profile_pic.jpg',
      isOnline: false,
      isFemale: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _swiperController = CardSwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      // show the "all caught up!" screen
      return AllCaughtUpScreen(
        onComplete: () => Navigator.pop(context),
        onStartOver: () {
          setState(() {
            _isFinished = false;
            _currentIndex = 0;
            _swiperController.dispose();
            _swiperController = CardSwiperController();
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF4),
      body: SafeArea(
        child: Stack(
          children: [
            // Top bar with close + progress
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: (_currentIndex + 1) / _dogs.length,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(255, 185, 71, 1),
                        ),
                        minHeight: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Card swiper
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 100),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final cw = constraints.maxWidth * 0.85;
                    final ch = constraints.maxHeight * 0.85;
                    return Center(
                      child: SizedBox(
                        width: cw,
                        height: ch,
                        child: CardSwiper(
                          controller: _swiperController,
                          cardsCount: _dogs.length,
                          onSwipe: _onSwipe,
                          onUndo: _onUndo,
                          onEnd: _onEnd,
                          numberOfCardsDisplayed: 2,
                          backCardOffset: Offset.zero,
                          padding: EdgeInsets.zero,
                          maxAngle: 30,
                          threshold: 50,
                          allowedSwipeDirection:
                              const AllowedSwipeDirection.only(
                            left: true,
                            right: true,
                          ),
                          scale: 1.0,
                          cardBuilder: (ctx, idx, hx, vx) {
                            return Transform.rotate(
                              angle: (hx * 0.04) * 0.0174533,
                              child: DogProfileCardOverlay(
                                imageUrl: _dogs[idx].imageUrl,
                                additionalImages: _dogs[idx].additionalImages,
                                name: _dogs[idx].name,
                                breed: _dogs[idx].breed,
                                age: _dogs[idx].age,
                                weight: _dogs[idx].weight,
                                distance: _dogs[idx].distance,
                                ownerImageUrl: _dogs[idx].ownerImageUrl,
                                isOnline: _dogs[idx].isOnline,
                                isFemale: _dogs[idx].isFemale,
                                onLike: () => _swiperController
                                    .swipe(CardSwiperDirection.right),
                                onChat: () {},
                                onMore: () {},
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bottom action buttons
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBottomButton(
                          Icons.close,
                          Colors.white,
                          Colors.black,
                          () =>
                              _swiperController.swipe(CardSwiperDirection.left),
                        ),
                        const SizedBox(width: 64),
                        _buildBottomButton(
                          Icons.favorite_outline,
                          Colors.white,
                          const Color(0xFFE94057),
                          () => _swiperController
                              .swipe(CardSwiperDirection.right),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 185, 71, 1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/Chat_icon_filled.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(int prev, int? curr, CardSwiperDirection direction) {
    setState(() => _currentIndex = curr ?? _currentIndex);
    return true;
  }

  bool _onUndo(int? prev, int curr, CardSwiperDirection dir) {
    return true;
  }

  void _onEnd() {
    setState(() => _isFinished = true);
  }

  Widget _buildBottomButton(
    IconData icon,
    Color bg,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 32),
      ),
    );
  }
}

/// The "All caught up!" screen
class AllCaughtUpScreen extends StatelessWidget {
  final VoidCallback onComplete;
  final VoidCallback onStartOver;

  const AllCaughtUpScreen({
    super.key,
    required this.onComplete,
    required this.onStartOver,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF4),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Column(
            children: [
              // top progress bar (full)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(255, 185, 71, 1),
                          ),
                          minHeight: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // checkmark
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFB947),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(24),
                child: const Icon(Icons.check_rounded,
                    size: 84, color: Colors.white),
              ),

              const SizedBox(height: 24),
              const Text(
                'All caught up!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const Spacer(),

              // Complete button
              CustomButton(
                text: 'Complete',
                onPressed: onComplete,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),

              // Start Over
              CustomButton(
                text: 'Start Over',
                onPressed: onStartOver,
                variant: CustomButtonVariant.outlined,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
