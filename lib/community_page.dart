import 'package:flutter/material.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/sticky_header.dart';
import 'widgets/post_widget.dart';
import 'lost_and_found_page.dart';
import 'matching_screen.dart';
import 'discover_page.dart';
import 'My_profilePage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'create_post_screen.dart';
import 'Notifications.dart';
import 'community_post_detail_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> posts = [
    {
      'profileImageUrl':
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
      'userName': 'Rich Froning',
      'timeAgo': '11m',
      'content':
          'My pup has been lonely up until now so we\'d love for him to make new friends and socialize❤️‼️',
      'imageUrl': 'assets/images/dog.png',
      'likesCount': 12,
      'commentsCount': 1,
    },
    {
      'profileImageUrl':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      'userName': 'Megan Hunt',
      'timeAgo': '1h',
      'content':
          'I took this one a few days after i got her, I love it so much 🐾',
      'imageUrl': 'assets/images/dog2.jpg',
      'likesCount': 45,
      'commentsCount': 8,
    },
    {
      'profileImageUrl':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
      'userName': 'David Cooper',
      'timeAgo': '2h',
      'content':
          'First day at the park with Max! He\'s loving every minute of it 🐕🌳\nWho else takes their dog here?',
      'imageUrl': 'assets/images/dog3.jpg',
      'likesCount': 89,
      'commentsCount': 15,
    },
    {
      'profileImageUrl':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80',
      'userName': 'Sarah Wilson',
      'timeAgo': '3h',
      'content':
          'Looking for playdate recommendations in Alexandria area! Luna is super friendly and loves making new friends 🐾💕',
      'imageUrl': 'assets/images/dog4.jpg',
      'likesCount': 67,
      'commentsCount': 23,
    },
    {
      'profileImageUrl':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
      'userName': 'Mike Johnson',
      'timeAgo': '5h',
      'content':
          'Just completed our first training session! So proud of how well Charlie did today 🎓🐕\nAny training tips from experienced owners?',
      'imageUrl': 'assets/images/dog.png',
      'likesCount': 156,
      'commentsCount': 42,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on community page
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyProfilePage()),
        );
        break;
    }
  }

  void _showCreatePostModal() async {
    // Now navigates to CreatePostScreen and handles result
    final newPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatePostScreen(),
      ),
    );
    if (newPost != null && newPost is Map<String, dynamic>) {
      setState(() {
        posts.insert(0, newPost);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
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
                title: 'Community',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
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
                            builder: (context) => const Notifications_AppPage(),
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
                        // TODO: Navigate to chat screen
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      // Create Post Widget at the top
                      return CreatePostWidget(onTap: _showCreatePostModal);
                    }
                    final post = posts[index - 1];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommunityPostDetailPage(
                                  userName: post['userName'],
                                  timeAgo: post['timeAgo'],
                                  content: post['content'],
                                  imageUrl: post['imageUrl'],
                                  likesCount: post['likesCount'],
                                  commentsCount: post['commentsCount'],
                                ),
                              ),
                            );
                          },
                          child: PostWidget(
                            profileImageUrl: post['profileImageUrl'],
                            userName: post['userName'],
                            timeAgo: post['timeAgo'],
                            content: post['content'],
                            imageUrl: post['imageUrl'],
                            likesCount: post['likesCount'],
                            commentsCount: post['commentsCount'],
                            onLikePressed: () {},
                            onCommentPressed: () {},
                            onSharePressed: () {},
                            onMorePressed: () {
                              // Show report dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Report',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'Do you want to report this post?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(height: 24),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 30,
                                                    vertical: 12,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content:
                                                          Text('Post reported'),
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Report',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        if (index - 1 < posts.length - 1)
                          const SizedBox(height: 16),
                      ],
                    );
                  },
                  childCount: posts.length + 1, // +1 for create post
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
  }
}

class CreatePostWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const CreatePostWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  "What's on your pup mind?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.photo_camera, color: Colors.grey[600]),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
