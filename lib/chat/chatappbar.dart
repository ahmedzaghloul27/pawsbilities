//packages
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//widgets
import '/chat/usersearchpopup.dart';

class ChatAppbar extends StatelessWidget {
  String userName, email;
  ChatAppbar({super.key, required this.userName, required this.email});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final addIconSize = screenWidth * 0.065;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black87,
          child: Icon(
            color: Colors.white,
            size: 20,
            Icons.more_horiz_rounded,
          ),
        ),
        const SizedBox(height: 7.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Chats",
              style: TextStyle(fontSize: 40, fontFamily: "PoppinsBold"),
            ),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => UserSearchBottomSheet(
                  userName: userName,
                  email: email,
                ),
              ),
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: addIconSize,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
