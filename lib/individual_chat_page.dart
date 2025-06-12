import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:pawsbilities_app/services/api_service.dart';

enum MessageType { text, image, location }

class IndividualChatPage extends StatefulWidget {
  final String name;
  final String? profileImage;

  const IndividualChatPage({
    super.key,
    required this.name,
    this.profileImage,
  });

  @override
  State<IndividualChatPage> createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final List<ChatMessage> messages = [
    ChatMessage(
      text: 'Thanks for telling',
      isMe: false,
      time: '09:41 AM',
      type: MessageType.text,
    ),
    ChatMessage(
      text: 'I\'ve tried the app',
      isMe: true,
      time: '09:41 AM',
      type: MessageType.text,
    ),
    ChatMessage(
      text: 'Yeah, It\'s really good!',
      isMe: true,
      time: '09:41 AM',
      type: MessageType.text,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Extract first name from full name
    String firstName = widget.name.split(' ').first;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom header with drop shadow
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: widget.profileImage != null
                          ? AssetImage(widget.profileImage!)
                          : null,
                      child: widget.profileImage == null
                          ? Icon(Icons.person,
                              color: Colors.grey[600], size: 16)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        firstName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(message: message, isFirstMessage: index == 0);
              },
            ),
          ),
          // Input field
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.location_on_outlined,
                      size: 28, color: Colors.grey),
                  onPressed: _sendLocation,
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined,
                      size: 28, color: Colors.grey),
                  onPressed: _pickAndSendImage,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Color.fromARGB(255, 196, 196, 196),
                        width: 2.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type a message',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _sendMessage,
                          child: const Text(
                            'Send',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 153, 0),
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: _messageController.text.trim(),
          isMe: true,
          time:
              '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} AM',
          type: MessageType.text,
        ));
      });
      _messageController.clear();
    }
  }

  Future<void> _pickAndSendImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        final url = await ApiService.uploadImage(File(image.path),
            folder: 'chat_images');
        setState(() {
          messages.add(ChatMessage(
            text: url ?? image.path,
            isMe: true,
            time:
                '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} AM',
            type: MessageType.image,
          ));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _sendLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled')),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Location permissions are permanently denied')),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        messages.add(ChatMessage(
          text: '${position.latitude},${position.longitude}',
          isMe: true,
          time:
              '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} AM',
          type: MessageType.location,
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final MessageType type;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.type,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isFirstMessage;

  const ChatBubble({
    super.key,
    required this.message,
    this.isFirstMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          // Time stamp
          if (isFirstMessage)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                message.time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          // Message bubble
          Row(
            mainAxisAlignment:
                message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color:
                      message.isMe ? const Color(0xFFFFB84D) : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: message.isMe
                        ? const Radius.circular(20)
                        : const Radius.circular(4),
                    bottomRight: message.isMe
                        ? const Radius.circular(4)
                        : const Radius.circular(20),
                  ),
                ),
                child: _buildMessageContent(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.text,
          style: TextStyle(
            color: message.isMe ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        );
      case MessageType.image:
        final isUrl = message.text.startsWith('http');
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: isUrl
              ? Image.network(
                  message.text,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 200,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                )
              : Image.file(
                  File(message.text),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
        );
      case MessageType.location:
        final coordinates = message.text.split(',');
        final lat = coordinates[0];
        final lng = coordinates[1];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: message.isMe ? Colors.white : Colors.black,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Location',
                  style: TextStyle(
                    color: message.isMe ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Lat: $lat\nLng: $lng',
              style: TextStyle(
                color: message.isMe ? Colors.white70 : Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        );
    }
  }
}
