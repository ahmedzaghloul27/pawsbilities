import 'package:flutter/material.dart';
import 'quiz_page4.dart';
class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _QuizPageState();
}

class _QuizPageState extends State<Page3> {
  int _selectedIndex = -1;

final List<Map<String, String>> _options = [
  {
    'title': 'Excitability',
    'subtitle': 'your dog overreacts or has difficulty calming down',
  },
  {
    'title': 'Aggression',
    'subtitle': 'your dog growls, barks, or even attempts to bite',
  },
  {
    'title': 'Calmness',
    'subtitle': 'calmly walk over, stare from afar',
  },
  {
    'title': 'Fear or Anxiety',
    'subtitle': 'your dog tries to cower, retreat or hide',
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Type Quiz'),
        centerTitle: true, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Question
            const QuestionText(
              question: "How does your pet react around a moving object or a creature?",
            ),

            const SizedBox(height: 16),

            // Image (optional)
            SizedBox(
              height: 150,
              child: Image.asset(
                'assets/image4.jpg',
                // fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            // Answer Option


            
ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: _options.length,
  itemBuilder: (context, index) {
    return AnswerOption(
      title: _options[index]['title']!,
      subtitle: _options[index]['subtitle']!,
      isSelected: _selectedIndex == index,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  },
),

            // Next Button
            ElevatedButton(
              onPressed: _selectedIndex == -1
                  ? null
                  : () {
                      // // For now, just show a message
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Selected: ${_options[_selectedIndex]}'),
                      //   ),
                      // );
                      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Page4()),
                      );
                    },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}



// --- Reusable Widgets ---

class QuestionText extends StatelessWidget {
  final String question;

  const QuestionText({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      question,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class AnswerOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerOption({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blue.shade100 : Colors.white,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.blue)
            : const Icon(Icons.circle_outlined),
        onTap: onTap,
      ),
    );
  }
}
