//packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawsbilities_app/chat/chatservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//widgets
import '/chat/chatbubble.dart';

class ChatScreen extends StatefulWidget {
  final String name, userName, email;

  const ChatScreen({
    super.key,
    required this.name,
    required this.userName,
    required this.email,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_controller.text.isNotEmpty) {
      await _chatServices.sendMessage(
          widget.userName, widget.email, widget.name, _controller.text.trim());
      _controller.clear();
    }
  }

  final List<Map<String, String>> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 30,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
                child: Icon(
              Icons.person,
              size: 26,
            )),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(height: 2.5),
                const Text(
                  "last seen 05:43 pm",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black38,
                    fontFamily: "PoppinsMid",
                  ),
                ),
                const SizedBox(height: 3),
              ],
            ),
            const SizedBox(width: 165),
            const Icon(Icons.more_vert)
          ],
        ),
        elevation: 6, // controls the shadow
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white, // or any color
        foregroundColor: Colors.black, // icon/text color
      ),
      body: Stack(
        children: [
          // 🔽 Wallpaper image
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/doodle2.jpg', // 🔁 Change to your actual image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔽 Chat content
          Column(
            children: [
              // messages.isNotEmpty
              //     ? Expanded(
              //         child: Column(
              //           children: [
              //             const SizedBox(height: 200),
              //             Opacity(
              //               opacity: 1,
              //               child: Image.asset(
              //                 "./assets/images/hello.gif",
              //                 height: 200,
              //               ),
              //             ),
              //             const Text(
              //               "No messages yet.",
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontFamily: "Poppins",
              //                 color: Color.fromARGB(100, 0, 0, 0),
              //               ),
              //             ),
              //             const Text(
              //               "Type your first message below!",
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontFamily: "Poppins",
              //                 color: Color.fromARGB(100, 0, 0, 0),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     // : Expanded(
              //     //     child: ListView(
              //     //       padding: const EdgeInsets.all(12),
              //     //       children: messages.map((msg) {
              //     //         return ChatBubble(
              //     //           text: msg['text'] ?? '',
              //     //           isSent: msg['user'] == InboxScreen().username,
              //     //           timestamp: DateTime.now(),
              //     //           isSeen: false,
              //     //         );
              //     //       }).toList(),
              //     //     ),
              //     //   ),
              Expanded(child: _buildMessageList()),

              /// Place this at the bottom of your `Column` in the `body`
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -2),
                      blurRadius: 6,
                    ),
                  ],
                  border: Border(
                    top: BorderSide(color: Colors.black12, width: 1),
                  ),
                ),
                padding: const EdgeInsets.only(right: 5, top: 15, bottom: 35),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.attach_file_rounded,
                        size: 35,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 40,
                          maxHeight: 200, // limit vertical growth
                        ),
                        child: Scrollbar(
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                            maxLines: null, // grow as needed
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.deepPurple,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2.5),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: sendMessage,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatServices.getMessages(widget.userName, widget.name),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            /////////// LOADING ANIMATION /////////////////////
            return const Text("Loading...");
          }

          return ListView(
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    bool sender;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    data['senderId'] == widget.userName ? sender = true : sender = false;

    var alignment = sender ? Alignment.centerRight : Alignment.centerLeft;

    return ChatBubble(
      text: data['message'],
      isSent: sender,
      timestamp: DateTime.now(),
      isSeen: false,
    );
//     return Container(alignment: alignment, child: Column(
// children: [
//   Text(data['message']),
//   Text(data['emao'])
// ],
//     ),);
  }
}
