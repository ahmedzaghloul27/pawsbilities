//packages
// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

//screens
import 'package:pawsbilities_app/chat/searchbar.dart';
import 'package:pawsbilities_app/chat_detail_screen.dart';

//widgets
import 'chatappbar.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({super.key});
  static const routeName = './inbox.dart';

  final List<Map<String, dynamic>> chats = [
    // {
    //   'name': 'Mohammed Osama',
    //   'message': 'habeby el ghaly',
    //   'time': '9:41 AM',
    //   'unread': true,
    // },
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 65, horizontal: 15),
        child: Column(
          children: [
            ChatAppbar(userName: args['userName'], email: args['email']),
            SizedBox(height: 15),
            Searchbar(),
            SizedBox(height: 20),
            Divider(),
            // SizedBox(height: 100),
            chats.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 350,
                        child: Image.asset(
                          "./assets/images/chat2.gif",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Text(
                        "You have no chats.",
                        style:
                            TextStyle(fontSize: 26, fontFamily: "PoppinsMid"),
                      ),
                      Text(
                        "Start Chatting!",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: "Poppins",
                            color: Colors.black45),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return ListTile(
                        leading: CircleAvatar(child: Icon(Icons.person)),
                        title: Text(chat['name']),
                        subtitle: Text(chat['message']),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(chat['time']),
                            if (chat['unread'])
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.orange,
                                child: Text('1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ChatDetailScreen(name: chat['name'])),
                          );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
