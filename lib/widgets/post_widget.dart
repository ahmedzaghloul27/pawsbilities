import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostWidget extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String timeAgo;
  final String content;
  final String imageUrl;
  final int likesCount;
  final int commentsCount;
  final VoidCallback? onProfileTap;
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
    this.onProfileTap,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: onProfileTap,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                    ),
                    const SizedBox(height: 18), // Space under avatar
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: onProfileTap,
                            child: Text(
                              userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            timeAgo,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: onMorePressed,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
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
                        child: imageUrl.startsWith('http')
                            ? Image.network(
                                imageUrl,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 200,
                                    width: double.infinity,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.error_outline,
                                        color: Colors.grey),
                                  );
                                },
                              )
                            : Image.asset(
                                imageUrl,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 200,
                                    width: double.infinity,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.error_outline,
                                        color: Colors.grey),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
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
                        SvgPicture.asset(
                          'assets/icons/comment.svg',
                          width: 20,
                          height: 20,
                          color: Colors.grey[600],
                        ),
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
                    child: SvgPicture.asset(
                      'assets/icons/share_icon.svg',
                      width: 20,
                      height: 20,
                      color: Colors.grey[600],
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
}
