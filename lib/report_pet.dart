import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'widgets/three_item_header.dart';

class ReportPet extends StatefulWidget {
  const ReportPet({Key? key}) : super(key: key);

  @override
  ReportPetState createState() => ReportPetState();
}

class ReportPetState extends State<ReportPet> {
  bool isLost = true;
  List<File?> images = [null, null, null]; // initially all empty (null)
  bool allowCalls = false;

  final TextEditingController nameOrTitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(int index) async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        images[index] = File(picked.path);
      });
    }
  }

  void togglePostType(bool lost) {
    setState(() {
      isLost = lost;
    });
  }

  Widget _buildPhotoPicker() {
    List<String> placeholderUrls = [
      "https://hips.hearstapps.com/hmg-prod/images/livestock-dogs-farm-dogs-german-shepherd-66e8667aed873.jpg?crop=0.6669811320754717xw:1xh;center,top&resize=980:*",
      "https://biznakenya.com/wp-content/uploads/2023/01/pexels-adam-kontor-333083-scaled-768x512.jpg",
      "https://via.placeholder.com/150",
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(3, (index) {
        return GestureDetector(
          onTap: () => pickImage(index),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: images[index] != null
                      ? FileImage(images[index]!)
                      : NetworkImage(placeholderUrls[index]) as ImageProvider,
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPostTypeButton(String text, bool isThisLost) {
    bool isSelected = (isLost == isThisLost);

    return Expanded(
      child: GestureDetector(
        onTap: () => togglePostType(isThisLost),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade400),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(color: Colors.grey[600]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ThreeItemHeader(
              title: 'Create Ad',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              trailing: GestureDetector(
                onTap: () {
                  // TODO: Post ad logic
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Add up to 3 photos and at least one",
                      style: TextStyle(fontSize: 21),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Make sure to use real and clear photos and not catalogs.",
                      style:
                          TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 10),
                    _buildPhotoPicker(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildPostTypeButton("Lost", true),
                        const SizedBox(width: 10),
                        _buildPostTypeButton("Found", false),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameOrTitleController,
                      decoration: InputDecoration(
                          labelText: isLost ? "Pet name" : "Title",
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 18)),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          labelText: "Description",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17)),
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      items: ["Park", "Street", "Home", "Vet"].map((location) {
                        return DropdownMenuItem(
                            value: location, child: Text(location));
                      }).toList(),
                      onChanged: (value) {
                        locationController.text = value!;
                      },
                      decoration: InputDecoration(
                        labelText: isLost
                            ? "Select last seen location"
                            : "Select location",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: allowCalls,
                          onChanged: (val) {
                            setState(() {
                              allowCalls = val!;
                            });
                          },
                        ),
                        const Expanded(
                            child: Text("Allow others to phone call you")),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
