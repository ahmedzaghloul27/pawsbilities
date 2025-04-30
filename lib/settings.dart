import 'package:flutter/material.dart';
import 'package:pawsbilities_app/sign_in_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Your account',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'See information about your account.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const YourAccountPage()),
          ),
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: const Text(
              'Matching Preferences',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Set your match distance, location, etc.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const MatchPreferencesPage()),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text(
              'Two-factor authentication',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Require a second authentication method.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const TwoFactorAuthPage()),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text(
              'Notifications',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Select the notifications you get.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const NotificationsPage()),
          ),
          ListTile(
            leading: const Icon(Icons.help_center),
            title: const Text(
              'Help center',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Get in touch and we will help you.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const HelpCenterPage()),
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text(
              'FAQ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Your guide to finding the perfect match.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const FAQPage()),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'About',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Know more about Pawsibilities.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const AboutPage()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Sign out',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () => _navigateTo(context, const SignInPage()), //for now
          ),
        ],
      ),
    );
  }
}

class YourAccountPage extends StatelessWidget {
  const YourAccountPage({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your account')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Account info'),
            onTap: () {
              // Navigate to account info page
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Change email'),
            onTap: () => _navigateTo(context, const ChangeEmailPage()),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change password'),
            onTap: () => _navigateTo(context, const ChangePasswordPage()),
          ),
          ListTile(
            title: const Text(
              'Delete account',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Handle delete account
            },
          ),
        ],
      ),
    );
  }
}

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'New email'),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(labelText: 'Confirm new email'),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(labelText: 'Current password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle email update
              },
              child: const Text('Complete'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Current password'),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(labelText: 'New password'),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(labelText: 'Confirm new password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle password update
              },
              child: const Text('Complete'),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchPreferencesPage extends StatefulWidget {
  const MatchPreferencesPage({super.key});

  @override
  State<MatchPreferencesPage> createState() => _MatchPreferencesPageState();
}

class _MatchPreferencesPageState extends State<MatchPreferencesPage> {
  String _location = 'Alexandria, Miami';
  double _distance = 30;
  bool _showFurtherAway = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match preferences')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Location', style: TextStyle(fontSize: 16)),
                // For demonstration, a simple DropdownButton:
                DropdownButton<String>(
                  value: _location,
                  items: <String>[
                    'Alexandria, Montaza',
                    'Alexandria, Miami',
                    'Alexandria, Sedi-beshr',
                    'Alexandria, Mohamed-nagib',
                    'Alexandria, Louran',
                    'Alexandria, Gleem',
                    'Alexandria, Sedi-gaber',
                    'Alexandria, Smoha',
                    'Alexandria, Sporting',
                    'Alexandria, Manshia',
                    'Alexandria, Mahtet-raml',
                  ].map((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      if (val != null) _location = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Distance slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Maximum distance'),
                Text('${_distance.round()} km'),
              ],
            ),
            Slider(
              value: _distance,
              min: 2,
              max: 100,
              divisions: 98,
              onChanged: (value) {
                setState(() {
                  _distance = value;
                });
              },
            ),
            const SizedBox(height: 8),

            SwitchListTile(
              title: const Text(
                'Show pets further away if I run out of profiles',
              ),
              value: _showFurtherAway,
              onChanged: (val) {
                setState(() {
                  _showFurtherAway = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TwoFactorAuthPage extends StatefulWidget {
  const TwoFactorAuthPage({super.key});

  @override
  State<TwoFactorAuthPage> createState() => _TwoFactorAuthPageState();
}

class _TwoFactorAuthPageState extends State<TwoFactorAuthPage> {
  bool _is2FAEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2-FA')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Two factor authentication'),
            subtitle: const Text('Require a second authentication method.'),
            value: _is2FAEnabled,
            onChanged: (value) {
              setState(() {
                _is2FAEnabled = value;
              });
              // Add logic to handle enabling/disabling 2FA
            },
          ),
        ],
      ),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool likesMatches = true;
  bool newMessages = true;
  bool foundPetAlert = true;
  bool likesOnPosts = true;
  bool likesOnComments = true;
  bool commentsOnPosts = true;
  bool postRecommendations = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Likes & Matches'),
            value: likesMatches,
            onChanged: (value) => setState(() => likesMatches = value),
          ),
          SwitchListTile(
            title: const Text('New messages'),
            value: newMessages,
            onChanged: (value) => setState(() => newMessages = value),
          ),
          SwitchListTile(
            title: const Text('Found pet alert'),
            value: foundPetAlert,
            onChanged: (value) => setState(() => foundPetAlert = value),
          ),
          SwitchListTile(
            title: const Text('Likes on your posts'),
            value: likesOnPosts,
            onChanged: (value) => setState(() => likesOnPosts = value),
          ),
          SwitchListTile(
            title: const Text('Likes on your comments'),
            value: likesOnComments,
            onChanged: (value) => setState(() => likesOnComments = value),
          ),
          SwitchListTile(
            title: const Text('Comments on your posts'),
            value: commentsOnPosts,
            onChanged: (value) => setState(() => commentsOnPosts = value),
          ),
          SwitchListTile(
            title: const Text('Posts recommendation'),
            value: postRecommendations,
            onChanged: (value) => setState(() => postRecommendations = value),
          ),
        ],
      ),
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help Center')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: Icon(Icons.email, color: Colors.blue),
            title: Text(
              'Contact us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('contact@pawsibilities.com'),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            title: Text('Getting Started',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('Download and Install'),
            subtitle: Text(
                'Find the app on the App Store or Google Play and install it.'),
          ),
          ListTile(
            title: Text('Sign Up'),
            subtitle:
                Text('Create an account using email, phone, or social media.'),
          ),
          ListTile(
            title: Text('Create Your Profile'),
            subtitle: Text(
                'Add personal and pet details including name, breed, and age.'),
          ),
          Divider(),
          ListTile(
            title: Text('How to Use the App',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('Browsing Matches'),
            subtitle:
                Text('Use filters to find potential matches for your pet.'),
          ),
          ListTile(
            title: Text('Messaging'),
            subtitle: Text('Chat with other pet owners after a mutual match.'),
          ),
          ListTile(
            title: Text('Notifications'),
            subtitle:
                Text('Stay updated with new matches, messages, and alerts.'),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About the Pet Mating App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'The Pet Mating App helps pet owners find suitable mates for their pets. '
              'It ensures responsible pet breeding while creating a community of pet lovers.',
            ),
            SizedBox(height: 20),
            Text(
              'Key Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
                '- Personalized pet profiles with breed, age, and health details.'),
            Text('- Smart Matching based on breed, location, and preferences.'),
            Text(
                '- Secure Messaging for safe communication between pet owners.'),
            Text('- Health Record Sharing for transparency.'),
            Text('- Subscription options for premium features.'),
          ],
        ),
      ),
    );
  }
}
