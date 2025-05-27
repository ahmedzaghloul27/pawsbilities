//packages
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

//widgets
import '/chat/messageModel.dart';

class ChatServices extends ChangeNotifier {
  //get instances of auth and firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //SEND MESSAGES
  Future<void> sendMessage(String currentUserID, String currentUseremail,
      String reciverId, String message) async {
    //get current user info
    final String currentUserId = currentUserID;
    final String currentUserEmail = currentUseremail;
    // final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      reciverId: reciverId,
      message: message,
      // timestamp: timestamp,
    );

    //construct chat room id from current user id and reciver id (to ensure uniqeuness)
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    String chatRoomId = ids.join("-");

    //add new message to database
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userId, String otheruUserId) {
    List<String> ids = [userId, otheruUserId];
    ids.sort();
    String chatRoomId = ids.join("-");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .snapshots();
    // .orderBy('timestamp', descending: false)
  }
}
