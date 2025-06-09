import 'package:flutter/material.dart';
import 'dart:io';
import 'profile_setup_complete.dart';
import '../widgets/custom_button.dart';

class SetPetDetailsPage extends StatefulWidget {
  final List<File?> petImages;
  final bool isFromProfile;

  const SetPetDetailsPage({
    super.key,
    required this.petImages,
    this.isFromProfile = false,
  });

  @override
  State<SetPetDetailsPage> createState() => _SetPetDetailsPageState();
}

class _SetPetDetailsPageState extends State<SetPetDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _petNameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();

  String? _selectedGender;
  String? _selectedVaccinationStatus;

  @override
  void dispose() {
    _petNameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _onCompletePressed() {
    if (_formKey.currentState!.validate()) {
      if (widget.isFromProfile) {
        // Return pet data to profile page - need to pop back to profile
        Navigator.of(context).pop(); // Pop details page
        Navigator.of(context).pop({
          'mainImage': widget.petImages[0]?.path ?? 'assets/images/dog.png',
          'additionalImages': widget.petImages
              .skip(1)
              .where((img) => img != null)
              .map((img) => img!.path)
              .toList(),
          'name': _petNameController.text,
          'breed': _breedController.text,
          'age': _ageController.text,
          'weight': _weightController.text,
          'gender': _selectedGender,
          'vaccinationStatus': _selectedVaccinationStatus,
        });
      } else {
        // Continue to profile setup complete for registration flow
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileSetupCompletePage(),
          ),
        );
      }
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
                  if (!widget.isFromProfile)
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
                'Tell us about\nyour pet',
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fill in the details to complete your pet profile.',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              // Show selected images preview

              const SizedBox(height: 24),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _CustomTextField(
                          hint: 'Pet Name',
                          controller: _petNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter pet name';
                            }
                            return null;
                          },
                        ),
                        _CustomTextField(
                          hint: 'Breed',
                          controller: _breedController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter breed';
                            }
                            return null;
                          },
                        ),
                        _CustomDropdownField(
                          hint: 'Gender',
                          options: const ['Male', 'Female'],
                          value: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select gender';
                            }
                            return null;
                          },
                        ),
                        _CustomTextField(
                          hint: 'Age',
                          controller: _ageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter age';
                            }
                            return null;
                          },
                        ),
                        _CustomDropdownField(
                          hint: 'Vaccination Status',
                          options: const ['Yes', 'No'],
                          value: _selectedVaccinationStatus,
                          onChanged: (value) {
                            setState(() {
                              _selectedVaccinationStatus = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select vaccination status';
                            }
                            return null;
                          },
                        ),
                        _CustomTextField(
                          hint: 'Weight',
                          controller: _weightController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter weight';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomButton(
                          text: 'Complete',
                          onPressed: _onCompletePressed,
                          backgroundColor: const Color(0xFFB88C59),
                          textColor: Colors.white,
                          borderRadius: 30,
                          height: 50,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const _CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: validator,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
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
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const _CustomDropdownField({
    super.key,
    required this.hint,
    required this.options,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        validator: validator,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
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
        onChanged: onChanged,
      ),
    );
  }
}
