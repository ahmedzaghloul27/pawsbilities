import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'set_pet_details_page.dart';
import '../widgets/custom_button.dart';

class SetPetPicturesPage extends StatefulWidget {
  const SetPetPicturesPage({super.key});

  @override
  State<SetPetPicturesPage> createState() => _SetPetPicturesPageState();
}

class _SetPetPicturesPageState extends State<SetPetPicturesPage> {
  final List<File?> _petImages = [null, null, null];
  int _currentImageIndex = 0;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _petImages[_currentImageIndex] = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> _showImageOptions(int index) async {
    _currentImageIndex = index;
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
              if (_petImages[index] != null)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove picture'),
                  onTap: () {
                    setState(() {
                      _petImages[index] = null;
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

  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPetDetailsPage(petImages: _petImages),
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
                "Set your pet\npictures",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                ),
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              const Text(
                'Add a main photo and 2 additional photos to showcase your pet.',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Main profile picture
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
                              radius: 80,
                              backgroundColor: Colors.white,
                              backgroundImage: _petImages[0] != null
                                  ? FileImage(_petImages[0]!) as ImageProvider
                                  : const AssetImage(
                                      'assets/images/avatar.png'),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: GestureDetector(
                              onTap: () => _showImageOptions(0),
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
                      const SizedBox(height: 20),
                      const Text(
                        "Main Profile Picture",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // Additional photos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildAdditionalPhotoCircle(1),
                          _buildAdditionalPhotoCircle(2),
                        ],
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

  Widget _buildAdditionalPhotoCircle(int index) {
    return GestureDetector(
      onTap: () => _showImageOptions(index),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: _petImages[index] != null
                  ? FileImage(_petImages[index]!)
                  : null,
              child: _petImages[index] == null
                  ? const Icon(Icons.camera_alt, color: Colors.grey, size: 32)
                  : null,
            ),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
