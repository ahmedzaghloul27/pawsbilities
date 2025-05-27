import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSent;
  final DateTime timestamp;
  final bool isSeen;
  const ChatBubble({
    super.key,
    required this.text,
    required this.isSent,
    required this.timestamp,
    required this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    final timeStr =
        "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isSent
                ? const Color.fromARGB(57, 124, 77, 255)
                : const Color(0xFFEFEFEF),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: Radius.circular(isSent ? 18 : 4),
              bottomRight: Radius.circular(isSent ? 4 : 18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 1),
                blurRadius: 1,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                timeStr,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
              if (isSent) ...[
                const SizedBox(width: 4),
                Icon(
                  isSeen ? Icons.done_all : Icons.done,
                  size: 14,
                  color: isSeen ? Colors.blue : Colors.black45,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
