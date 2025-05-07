import 'package:flutter/material.dart';
import 'package:pawsbilities_app/profile_setup_complete.dart';
import 'widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPetProfilePage extends StatefulWidget {
  const AddPetProfilePage({super.key});

  @override
  State<AddPetProfilePage> createState() => _AddPetProfilePageState();
}

class _AddPetProfilePageState extends State<AddPetProfilePage> {
  final List<File?> _petImages = [null, null, null];

  Future<void> _pickImage(int index) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _petImages[index] = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ProfileSetupCompletePage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Set your pet profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'You must add at least one photo to create your profile.',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                '*You can add more pets to your profile later',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () => _pickImage(index),
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
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: _petImages[index] != null
                                ? FileImage(_petImages[index]!)
                                : (index == 0
                                    ? const AssetImage(
                                        'assets/images/avatar.png')
                                    : null) as ImageProvider?,
                            child: _petImages[index] == null && index != 0
                                ? const Icon(Icons.camera_alt,
                                    color: Colors.grey, size: 32)
                                : null,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => _pickImage(index),
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: const Icon(Icons.add,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              const _PetProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PetProfileForm extends StatelessWidget {
  const _PetProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CustomTextField(hint: 'Pet Name'),
        _CustomTextField(hint: 'Breed'),
        _CustomDropdownField(
          hint: 'Gender',
          options: const ['Male', 'Female'],
        ),
        _CustomTextField(hint: 'Age'),
        _CustomDropdownField(
          hint: 'Vaccination Status',
          options: const ['Yes', 'No'],
        ),
        _CustomTextField(hint: 'Weight'),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Next',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileSetupCompletePage(),
              ),
            );
          },
          backgroundColor: const Color(0xFFB88C59),
          textColor: Colors.white,
          borderRadius: 30,
          height: 50,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String hint;
  const _CustomTextField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFB38E5D)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFB38E5D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFB38E5D), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class _CustomDropdownField extends StatelessWidget {
  final String hint;
  final List<String> options;
  const _CustomDropdownField(
      {super.key, required this.hint, required this.options});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFB38E5D)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFB38E5D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFB38E5D), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: options
            .map((val) => DropdownMenuItem(
                value: val,
                child:
                    Text(val, style: const TextStyle(fontFamily: 'Poppins'))))
            .toList(),
        onChanged: (val) {},
      ),
    );
  }
}
