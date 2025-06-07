import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_manager.dart';
import '../services/api_service.dart';

class BackendIntegrationExample extends StatefulWidget {
  @override
  _BackendIntegrationExampleState createState() =>
      _BackendIntegrationExampleState();
}

class _BackendIntegrationExampleState extends State<BackendIntegrationExample> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  List<Map<String, dynamic>> _pets = [];
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backend Integration Example'),
      ),
      body: Consumer<AuthManager>(
        builder: (context, authManager, child) {
          if (!authManager.isAuthenticated) {
            return _buildLoginScreen(authManager);
          } else {
            return _buildMainScreen(authManager);
          }
        },
      ),
    );
  }

  Widget _buildLoginScreen(AuthManager authManager) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          if (_isLoading)
            CircularProgressIndicator()
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _login(authManager),
                  child: Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () => _register(authManager),
                  child: Text('Register'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMainScreen(AuthManager authManager) {
    return Column(
      children: [
        // User info
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.blue[50],
          child: Row(
            children: [
              Text(
                  'Welcome, ${authManager.currentUser?['firstName']} ${authManager.currentUser?['lastName']}!'),
              Spacer(),
              ElevatedButton(
                onPressed: () => authManager.logout(),
                child: Text('Logout'),
              ),
            ],
          ),
        ),

        // Action buttons
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _loadPets(authManager),
                child: Text('Load Pets'),
              ),
              ElevatedButton(
                onPressed: () => _loadPosts(authManager),
                child: Text('Load Posts'),
              ),
              ElevatedButton(
                onPressed: () => _createSamplePet(authManager),
                child: Text('Add Pet'),
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: 'Pets (${_pets.length})'),
                          Tab(text: 'Posts (${_posts.length})'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildPetsList(),
                            _buildPostsList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildPetsList() {
    return ListView.builder(
      itemCount: _pets.length,
      itemBuilder: (context, index) {
        final pet = _pets[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(pet['name'] ?? 'Unknown'),
            subtitle: Text('${pet['breed']} - ${pet['age']}'),
            trailing: Text(pet['isAvailable'] ? 'Available' : 'Not Available'),
          ),
        );
      },
    );
  }

  Widget _buildPostsList() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(post['content'] ?? 'No content'),
            subtitle: Text(
                'Likes: ${post['likes']} | Comments: ${post['comments']?.length ?? 0}'),
          ),
        );
      },
    );
  }

  Future<void> _login(AuthManager authManager) async {
    setState(() => _isLoading = true);

    final success = await authManager.login(
      _emailController.text,
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed')),
      );
    }
  }

  Future<void> _register(AuthManager authManager) async {
    setState(() => _isLoading = true);

    final success = await authManager.register(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed')),
      );
    }
  }

  Future<void> _loadPets(AuthManager authManager) async {
    if (authManager.token == null) return;

    setState(() => _isLoading = true);

    final pets =
        await ApiService.getAvailablePetsForAdoption(authManager.token!);

    setState(() {
      _pets = pets;
      _isLoading = false;
    });
  }

  Future<void> _loadPosts(AuthManager authManager) async {
    if (authManager.token == null) return;

    setState(() => _isLoading = true);

    final posts = await ApiService.getCommunityPosts(authManager.token!);

    setState(() {
      _posts = posts;
      _isLoading = false;
    });
  }

  Future<void> _createSamplePet(AuthManager authManager) async {
    if (authManager.token == null) return;

    setState(() => _isLoading = true);

    final petData = {
      'name': 'Buddy',
      'breed': 'Golden Retriever',
      'age': '3 years',
      'weight': '30 kg',
      'gender': 'Male',
      'description': 'Friendly and energetic dog',
      'isAvailable': true,
    };

    final result = await ApiService.createPet(authManager.token!, petData);

    setState(() => _isLoading = false);

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pet created successfully!')),
      );
      // Reload pets
      _loadPets(authManager);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create pet')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
