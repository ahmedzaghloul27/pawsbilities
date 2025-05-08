import 'package:flutter/material.dart';

class Notifications_AppPage extends StatelessWidget {
  const Notifications_AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.whatshot,
        'color': Colors.orange,
        'title': 'Trending',
        'subtitle': 'Your Post is Trending in the hot Section',
        'time': '9.56 AM',
        'highlight': true,
      },
      {
        'icon': Icons.whatshot,
        'color': Colors.orange,
        'title': 'Trending',
        'subtitle': 'Your Post is Trending in the hot Section',
        'time': '9.56 AM',
        'highlight': false,
      },
      {
        'icon': Icons.comment,
        'color': Colors.deepPurple,
        'title': 'Comment',
        'subtitle': 'Someone commented on your post',
        'time': '9.56 AM',
        'highlight': false,
      },
      {
        'icon': Icons.favorite,
        'color': Colors.red,
        'title': 'Trending',
        'subtitle': 'Your Post is Trending in the Fun Section',
        'time': '9.56 AM',
        'highlight': false,
      },
      {
        'icon': Icons.comment,
        'color': Colors.deepPurple,
        'title': 'Comment',
        'subtitle': 'Someone commented on your post',
        'time': '9.56 AM',
        'highlight': false,
      },
      {
        'icon': Icons.favorite,
        'color': Colors.red,
        'title': 'Trending',
        'subtitle': 'Your Post is Trending in the Fun Section',
        'time': '9.56 AM',
        'highlight': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            color: item['highlight'] == true
                ? Colors.orange.shade50
                : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(item['icon'] as IconData,
                    color: item['color'] as Color, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                Text(
                  item['time'] as String,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
