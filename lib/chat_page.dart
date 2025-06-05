import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'individual_chat_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatItem> chats = [
    ChatItem(
      name: 'Mohammed Osama',
      lastMessage: 'habeby el ghaly',
      time: '9:41 AM',
      profileImage: 'assets/images/Profile_pic.jpg',
      unreadCount: 1,
    ),
    ChatItem(
      name: 'Mohammed Osama',
      lastMessage: 'yes, that\'s gonna work',
      time: '8:41 AM',
      profileImage: 'assets/images/Profile_pic.jpg',
      unreadCount: 0,
    ),
    ChatItem(
      name: 'Rich Froning',
      lastMessage: 'Cool let\'s meet',
      time: '7:41 AM',
      profileImage: 'assets/images/dog2.jpg',
      unreadCount: 0,
    ),
    ChatItem(
      name: 'Summer',
      lastMessage: 'hi',
      time: '6:41 AM',
      profileImage: null,
      unreadCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatListItem(
            chat: chat,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualChatPage(
                    name: chat.name,
                    profileImage: chat.profileImage,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String lastMessage;
  final String time;
  final String? profileImage;
  final int unreadCount;

  ChatItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    this.profileImage,
    required this.unreadCount,
  });
}

class ChatListItem extends StatelessWidget {
  final ChatItem chat;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[300],
              backgroundImage: chat.profileImage != null
                  ? AssetImage(chat.profileImage!)
                  : null,
              child: chat.profileImage == null
                  ? Icon(Icons.person, color: Colors.grey[600])
                  : null,
            ),
            const SizedBox(width: 16),
            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            chat.time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 20,
                            child: chat.unreadCount > 0
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFB84D),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        chat.unreadCount.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
