import 'package:flutter/material.dart';
import 'widgets/custom_nav_bar.dart';
import 'community_page.dart';
import 'matching_screen.dart';
import 'discover_page.dart';
import 'My_profilePage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Notifications.dart';
import 'report_pet.dart';
import 'widgets/small_pet_card.dart';
import 'all_pets_page.dart';
import 'pet_post_detail_page.dart';
import 'chat_page.dart';

class LostAndFoundPage extends StatefulWidget {
  const LostAndFoundPage({super.key});

  @override
  State<LostAndFoundPage> createState() => _LostAndFoundPageState();
}

class LostAndFoundHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final int tabIndex;
  final ValueChanged<int> onTabChanged;
  const LostAndFoundHeader({
    Key? key,
    required this.tabIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lost & Found',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    children: [
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
                ],
              ),
            ),
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              tabs: const [
                Tab(text: "Lost pet"),
                Tab(text: "Found pet"),
              ],
              onTap: onTabChanged,
              controller: TabController(
                length: 2,
                vsync: Scaffold.of(context),
                initialIndex: tabIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}

class _LostAndFoundPageState extends State<LostAndFoundPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 1;
  int _tabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: _tabIndex);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _tabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _tabIndex = index;
      _tabController.index = index;
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
        // Already on lost and found page
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyProfilePage()),
        );
        break;
    }
  }

  final List<Map<String, dynamic>> lostPets = [
    {
      "section": "Today",
      "pets": [
        {
          "name": "Mario",
          "breed": "Husky",
          "age": "2y",
          "weight": "20kg",
          "distance": 1.2,
          "isFemale": false,
          "location": "Louran",
          "image": "assets/images/dog.png"
        },
        {
          "name": "Mario",
          "breed": "Husky",
          "age": "2y",
          "weight": "20kg",
          "distance": 1.2,
          "isFemale": false,
          "location": "Louran",
          "image": "assets/images/dog.png"
        },
        {
          "name": "Mario",
          "breed": "Husky",
          "age": "2y",
          "weight": "20kg",
          "distance": 1.2,
          "isFemale": false,
          "location": "Louran",
          "image": "assets/images/dog.png"
        },
        {
          "name": "Mario",
          "breed": "Husky",
          "age": "2y",
          "weight": "20kg",
          "distance": 1.2,
          "isFemale": false,
          "location": "Louran",
          "image": "assets/images/dog.png"
        },
        {
          "name": "Joy",
          "breed": "Terrier",
          "age": "1y",
          "weight": "8kg",
          "distance": 2.5,
          "isFemale": true,
          "location": "Louran",
          "image": "assets/images/dog2.jpg"
        },
        {
          "name": "Max",
          "breed": "Labrador",
          "age": "3y",
          "weight": "25kg",
          "distance": 3.1,
          "isFemale": false,
          "location": "Miami",
          "image": "assets/images/dog3.jpg"
        },
        {
          "name": "Max",
          "breed": "Labrador",
          "age": "3y",
          "weight": "25kg",
          "distance": 3.1,
          "isFemale": false,
          "location": "Miami",
          "image": "assets/images/dog3.jpg"
        },
        {
          "name": "Max",
          "breed": "Labrador",
          "age": "3y",
          "weight": "25kg",
          "distance": 3.1,
          "isFemale": false,
          "location": "Miami",
          "image": "assets/images/dog3.jpg"
        },
        {
          "name": "Max",
          "breed": "Labrador",
          "age": "3y",
          "weight": "25kg",
          "distance": 3.1,
          "isFemale": false,
          "location": "Miami",
          "image": "assets/images/dog3.jpg"
        },
        {
          "name": "Max",
          "breed": "Labrador",
          "age": "3y",
          "weight": "25kg",
          "distance": 3.1,
          "isFemale": false,
          "location": "Miami",
          "image": "assets/images/dog3.jpg"
        },
      ]
    },
    {
      "section": "Yesterday",
      "pets": [
        {
          "name": "Rex",
          "breed": "Mixed",
          "age": "4y",
          "weight": "18kg",
          "distance": 4.2,
          "isFemale": false,
          "location": "Louran",
          "image": "assets/images/dog4.jpg"
        },
        {
          "name": "Buddy",
          "breed": "Golden",
          "age": "2y",
          "weight": "22kg",
          "distance": 2.8,
          "isFemale": false,
          "location": "Miami",
          "image": "assets/images/dog2.jpg"
        },
      ]
    },
    {
      "section": "Last 3 days",
      "pets": [
        {
          "name": "Lucky",
          "breed": "Beagle",
          "age": "1.5y",
          "weight": "10kg",
          "distance": 5.0,
          "isFemale": true,
          "location": "Sidi Gaber",
          "image": "assets/images/dog2.jpg"
        },
        {
          "name": "Bella",
          "breed": "Poodle",
          "age": "2y",
          "weight": "7kg",
          "distance": 6.3,
          "isFemale": true,
          "location": "Smouha",
          "image": "assets/images/dog2.jpg"
        },
      ]
    }
  ];

  final List<Map<String, dynamic>> foundPets = [
    {
      "section": "Today",
      "pets": [
        {
          "name": "Miami",
          "breed": "Labrador",
          "age": "3y",
          "weight": "25kg",
          "distance": 1.1,
          "isFemale": false,
          "location": "Miami",
          "image": "assets/images/dog3.jpg"
        },
        {
          "name": "Smouha",
          "breed": "Husky",
          "age": "2y",
          "weight": "20kg",
          "distance": 2.0,
          "isFemale": false,
          "location": "Smouha",
          "image": "assets/images/dog.png"
        },
        {
          "name": "Lola",
          "breed": "Terrier",
          "age": "1y",
          "weight": "8kg",
          "distance": 2.7,
          "isFemale": true,
          "location": "Louran",
          "image": "assets/images/dog2.jpg"
        },
      ]
    },
    {
      "section": "Yesterday",
      "pets": [
        {
          "name": "Seyof",
          "breed": "Mixed",
          "age": "4y",
          "weight": "18kg",
          "distance": 3.5,
          "isFemale": false,
          "location": "Seyof",
          "image": "assets/images/dog4.jpg"
        },
        {
          "name": "Sidi gaber",
          "breed": "Golden",
          "age": "2y",
          "weight": "22kg",
          "distance": 4.1,
          "isFemale": false,
          "location": "Sidi Gaber",
          "image": "assets/images/dog4.jpg"
        },
      ]
    },
    {
      "section": "Last 3 days",
      "pets": [
        {
          "name": "Bella",
          "breed": "Poodle",
          "age": "2y",
          "weight": "7kg",
          "distance": 6.3,
          "isFemale": true,
          "location": "Smouha",
          "image": "assets/images/dog4.jpg"
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      appBar: LostAndFoundHeader(
        tabIndex: _tabIndex,
        onTabChanged: _onTabChanged,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildPetList(context, lostPets, false),
                  buildPetList(context, foundPets, true),
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
  }

  Widget buildPetList(
      BuildContext context, List<Map<String, dynamic>> data, bool isFound) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 19, 19, 19),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportPet(),
                  ),
                );
              },
              child: Text(
                isFound ? "Report found pet" : "Report lost pet",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        ...data.map((section) {
          final pets = section['pets'] as List;
          if (pets.isEmpty) return const SizedBox();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      section['section'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllPetsPage(
                              title: isFound ? 'Found pets' : 'Lost pets',
                              section: section['section'],
                              pets: section['pets'],
                              isFound: isFound,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                            color: Color.fromRGBO(94, 94, 94, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pets.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: SmallPetCard(
                            imageUrl: pet['image'],
                            name: isFound ? "" : pet['name'],
                            breed: isFound ? "" : pet['breed'],
                            age: pet['age'],
                            weight: pet['weight'],
                            distance: pet['distance'],
                            isFemale: pet['isFemale'],
                            showGender: !isFound,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetPostDetailPage(
                                    title: isFound ? 'Found pet' : 'Lost pet',
                                    pet: pet,
                                    isFound: isFound,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (isFound)
                          Positioned(
                            bottom: 25,
                            left: 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.white, size: 18),
                                    const SizedBox(width: 4),
                                    Text(
                                      pet['location'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 2,
                                              color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
