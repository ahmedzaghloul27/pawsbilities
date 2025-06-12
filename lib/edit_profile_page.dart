import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pawsbilities_app/services/api_service.dart';

class EditProfilePage extends StatefulWidget {
  final String currentFirstName;
  final String currentLastName;
  final String currentEmail;
  final String currentBio;

  const EditProfilePage({
    super.key,
    required this.currentFirstName,
    required this.currentLastName,
    required this.currentEmail,
    required this.currentBio,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.currentFirstName);
    _lastNameController = TextEditingController(text: widget.currentLastName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _bioController = TextEditingController(text: widget.currentBio);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _saveProfile() async {
    String? photoUrl;
    if (_selectedImage != null) {
      photoUrl = await ApiService.uploadImage(
        _selectedImage!,
        folder: 'users_profile',
      );
    }

    Navigator.pop(context, {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'bio': _bioController.text.trim(),
      'profileImageUrl': photoUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: _saveProfile,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Color(0xFFB88C59),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : const AssetImage('assets/images/Profile_pic.jpg')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            // Form Fields

            _buildTextField(
              controller: _firstNameController,
              label: 'First Name',
              isEditable: true,
            ),
            const SizedBox(height: 18),

            _buildTextField(
              controller: _lastNameController,
              label: 'Last Name',
              isEditable: true,
            ),
            const SizedBox(height: 18),

            _buildTextField(
              controller: _emailController,
              label: 'Email',
              isEditable: false,
            ),
            const SizedBox(height: 18),

            _buildTextField(
              controller: _bioController,
              label: 'Bio',
              isEditable: true,
              maxLines: 4,
            ),
            const SizedBox(height: 40),

            // Save Button
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isEditable,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: isEditable,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 16,
            color: isEditable ? Colors.black : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isEditable ? Colors.white : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isEditable ? const Color(0xFFB88C59) : Colors.grey[300]!,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isEditable ? const Color(0xFFB88C59) : Colors.grey[300]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFB88C59),
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            suffixIcon: !isEditable
                ? Icon(Icons.lock, color: Colors.grey[400], size: 20)
                : null,
          ),
        ),
      ],
    );
  }
}
