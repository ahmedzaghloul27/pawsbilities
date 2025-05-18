import 'package:flutter/material.dart';
import 'pet_post_detail_page.dart';

class AllPetsPage extends StatelessWidget {
  final String title;
  final String section;
  final List<Map<String, dynamic>> pets;
  final bool isFound;

  const AllPetsPage({
    Key? key,
    required this.title,
    required this.section,
    required this.pets,
    this.isFound = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              '$section\'s Ads',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(
                  height: 1, thickness: 1, color: Colors.grey.withOpacity(0.2)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pet = pets[index];
                  return GestureDetector(
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(pet['image']),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Gradient overlay
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.8),
                                ],
                                stops: const [0.0, 0.6, 0.8, 1.0],
                              ),
                            ),
                          ),

                          // Pet info at bottom
                          Positioned(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            child: isFound
                                ? Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.white, size: 16),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          pet['location'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            pet['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            pet['isFemale']
                                                ? Icons.female
                                                : Icons.male,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        pet['location'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: pets.length,
              ),
            ),
          ),
          // Add some bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}
