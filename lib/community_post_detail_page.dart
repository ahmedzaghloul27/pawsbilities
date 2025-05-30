import 'package:flutter/material.dart';
import 'widgets/small_pet_card.dart';

class CommunityPostDetailPage extends StatefulWidget {
  final String userName;
  final String timeAgo;
  final String content;
  final String imageUrl;
  final int likesCount;
  final int commentsCount;

  const CommunityPostDetailPage({
    Key? key,
    required this.userName,
    required this.timeAgo,
    required this.content,
    required this.imageUrl,
    required this.likesCount,
    required this.commentsCount,
  }) : super(key: key);

  @override
  State<CommunityPostDetailPage> createState() =>
      _CommunityPostDetailPageState();
}

class _CommunityPostDetailPageState extends State<CommunityPostDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [
    {
      'userName': 'John Doe',
      'timeAgo': '15m',
      'content': 'This is adorable! 😍',
      'profileImage': 'assets/images/Profile_pic.jpg',
    },
    {
      'userName': 'Jane Smith',
      'timeAgo': '45m',
      'content': 'Great photo! Where was this taken?',
      'profileImage': 'assets/images/Profile_pic.jpg',
    },
    {
      'userName': 'Mark Wilson',
      'timeAgo': '1h',
      'content': 'Your pet is so cute! What breed is it?',
      'profileImage': 'assets/images/Profile_pic.jpg',
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // Method to show the image in a full-screen overlay
  void _showImageOverlay(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              Center(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              // Close button at the bottom
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to show the report overlay
  void _showReportOverlay(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        // Handle report action
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Post reported'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Report',
                        style: TextStyle(fontSize: 16),
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
  }

  void _addComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        comments.add({
          'userName': 'You',
          'timeAgo': 'Just now',
          'content': _commentController.text,
          'profileImage': 'assets/images/Profile_pic.jpg',
        });
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Post',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () => _showReportOverlay(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Divider after appbar
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              AssetImage('assets/images/Profile_pic.jpg'),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.timeAgo,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Post description
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.content,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                  ),

                  // Post image
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () => _showImageOverlay(context, widget.imageUrl),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          widget.imageUrl,
                          width: double.infinity,
                          height: 320,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Like and comment counts
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border,
                            color: Colors.grey[700], size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.likesCount} likes',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.chat_bubble_outline,
                            color: Colors.grey[700], size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.commentsCount} comments',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Comments section
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
                    child: Text(
                      'Comments',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // Comments list
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  AssetImage(comment['profileImage']),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        comment['userName'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        comment['timeAgo'],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    comment['content'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Related pets section
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 30, 16, 10),
                    child: Text(
                      'Pets you may like',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // Grid of related pets
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 140 / 138,
                      children: [
                        SmallPetCard(
                          imageUrl: 'assets/images/dog.png',
                          name: 'Fluffy',
                          breed: 'Shitzu',
                          age: '3 years',
                          weight: '6 kgs',
                          distance: 7,
                          isFemale: false,
                          onTap: () {},
                        ),
                        SmallPetCard(
                          imageUrl: 'assets/images/dog2.jpg',
                          name: 'Shenko',
                          breed: 'Husky',
                          age: '1.5 years',
                          weight: '22 kg',
                          distance: 4.2,
                          isFemale: false,
                          onTap: () {},
                        ),
                        SmallPetCard(
                          imageUrl: 'assets/images/dog3.jpg',
                          name: 'Cinnamon',
                          breed: 'Coonhound',
                          age: '10 months',
                          weight: '5 kg',
                          distance: 2.8,
                          isFemale: true,
                          onTap: () {},
                        ),
                        SmallPetCard(
                          imageUrl: 'assets/images/dog4.jpg',
                          name: 'Milo',
                          breed: 'Retriever',
                          age: '3 years',
                          weight: '32 kg',
                          distance: 5.0,
                          isFemale: false,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  // Bottom spacing
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Comment input field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/Profile_pic.jpg'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.black),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
