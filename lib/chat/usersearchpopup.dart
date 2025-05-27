// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawsbilities_app/chat/chat.dart';

class UserSearchBottomSheet extends StatefulWidget {
  String userName, email;
  UserSearchBottomSheet(
      {super.key, required this.userName, required this.email});

  @override
  State<UserSearchBottomSheet> createState() => _UserSearchBottomSheetState();
}

class _UserSearchBottomSheetState extends State<UserSearchBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _error;
  List<String> _userResults = [];

  Future<void> _onSearch() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://192.168.1.159:5001/users/finduser');
    final body = {"userName": _controller.text.trim()};

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final searchedUsername = data['userName'];
        setState(() {
          _error = null;
          _userResults = [searchedUsername];
        });
      } else {
        setState(() {
          _userResults.clear();
          _error = 'User not found.';
        });
      }
    } catch (e) {
      setState(() {
        _userResults.clear();
        _error = 'Error occurred while searching.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 200,
            child: Wrap(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      'New Chat',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'PoppinsSemiBold',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 75),
                TextField(
                  style: const TextStyle(fontFamily: 'Poppins'),
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black45,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _onSearch,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.teal,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                if (_isLoading)
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  ))
                else if (_error != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10.0, top: 25, left: 5),
                    child: Text(_error!,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                if (_userResults.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _userResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading:
                              const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(
                            _userResults[index],
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                    name: _userResults[index],
                                    userName: widget.userName,
                                    email: widget.email),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
