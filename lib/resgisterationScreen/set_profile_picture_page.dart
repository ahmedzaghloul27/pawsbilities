import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'set_pet_pictures_page.dart';
import '../widgets/custom_button.dart';
import 'package:pawsbilities_app/services/api_service.dart';

class SetProfilePicturePage extends StatefulWidget {
  final String firstName;
  final String lastName;

  const SetProfilePicturePage({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<SetProfilePicturePage> createState() => _SetProfilePicturePageState();
}

class _SetProfilePicturePageState extends State<SetProfilePicturePage> {
  File? _profileImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> _showImageOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture'),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Choose from gallery'),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
              if (_profileImage != null)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove picture'),
                  onTap: () {
                    setState(() {
                      _profileImage = null;
                    });
                    Navigator.pop(context);
                  },
                ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onNextPressed() async {
    String? photoUrl;
    if (_profileImage != null) {
      photoUrl = await ApiService.uploadImage(
        _profileImage!,
        folder: 'users_profile',
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetPetPicturesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 16),
              const Text(
                "Set your profile\npicture",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                ),
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 4),
                            ),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.white,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!) as ImageProvider
                                  : const AssetImage(
                                      'assets/images/avatar.png'),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: GestureDetector(
                              onTap: _showImageOptions,
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: const Icon(Icons.add,
                                    color: Colors.white, size: 26),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "${widget.firstName} ${widget.lastName}".toLowerCase(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Next button at bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomButton(
                  text: "Next",
                  onPressed: _onNextPressed,
                  backgroundColor: const Color(0xFFB38E5D),
                  textColor: Colors.white,
                  borderRadius: 30,
                  height: 50,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
