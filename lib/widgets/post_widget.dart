import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String timeAgo;
  final String content;
  final String imageUrl;
  final int likesCount;
  final int commentsCount;
  final VoidCallback? onLikePressed;
  final VoidCallback? onCommentPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onMorePressed;

  const PostWidget({
    super.key,
    required this.profileImageUrl,
    required this.userName,
    required this.timeAgo,
    required this.content,
    required this.imageUrl,
    required this.likesCount,
    required this.commentsCount,
    this.onLikePressed,
    this.onCommentPressed,
    this.onSharePressed,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onMorePressed,
                )
              ],
            ),
            const SizedBox(height: 12),
            // Post Content
            Text(
              content,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            // Post Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Post Actions
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: onLikePressed,
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border,
                            size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          likesCount.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: onCommentPressed,
                    child: Row(
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          commentsCount.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: onSharePressed,
                    child: Icon(Icons.share, size: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
