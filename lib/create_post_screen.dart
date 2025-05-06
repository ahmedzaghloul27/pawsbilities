import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isPosting = false;

  void _submitPost() {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isPosting = true);
    // Simulate post creation
    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.of(context).pop({
        'profileImageUrl':
            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
        'userName': 'Ahmed Zaghloul',
        'timeAgo': 'now',
        'content': _controller.text.trim(),
        'imageUrl': 'assets/images/dog.png', // Placeholder
        'likesCount': 0,
        'commentsCount': 0,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Create post',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
              onPressed: _controller.text.trim().isEmpty || _isPosting
                  ? null
                  : _submitPost,
              child: Text(
                'Post',
                style: TextStyle(
                  color: _controller.text.trim().isEmpty || _isPosting
                      ? Colors.grey
                      : Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d'),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Ahmed Zaghloul',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 6,
                minLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write your post or question here',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(height: 18),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onPressed: () {},
              icon: const Icon(Icons.image_outlined,
                  color: Colors.black87, size: 20),
              label: const Text(
                'Add media',
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
