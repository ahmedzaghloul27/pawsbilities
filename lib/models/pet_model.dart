import 'package:mongo_dart/mongo_dart.dart';

class Pet {
  final String? id;
  final String name;
  final String breed;
  final String age;
  final String weight;
  final bool isFemale;
  final String ownerId;
  final String imageUrl;
  final List<String> additionalImages;
  final String? personality;
  final String? description;
  final bool isAvailable;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pet({
    this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.weight,
    required this.isFemale,
    required this.ownerId,
    required this.imageUrl,
    this.additionalImages = const [],
    this.personality,
    this.description,
    this.isAvailable = true,
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from MongoDB document
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['_id']?.toString(),
      name: map['name'] ?? '',
      breed: map['breed'] ?? '',
      age: map['age'] ?? '',
      weight: map['weight'] ?? '',
      isFemale: map['isFemale'] ?? false,
      ownerId: map['ownerId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      additionalImages: List<String>.from(map['additionalImages'] ?? []),
      personality: map['personality'],
      description: map['description'],
      isAvailable: map['isAvailable'] ?? true,
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: map['updatedAt']?.toDate() ?? DateTime.now(),
    );
  }

  // Convert to MongoDB document
  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': ObjectId.parse(id!),
      'name': name,
      'breed': breed,
      'age': age,
      'weight': weight,
      'isFemale': isFemale,
      'ownerId': ownerId,
      'imageUrl': imageUrl,
      'additionalImages': additionalImages,
      'personality': personality,
      'description': description,
      'isAvailable': isAvailable,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Pet copyWith({
    String? id,
    String? name,
    String? breed,
    String? age,
    String? weight,
    bool? isFemale,
    String? ownerId,
    String? imageUrl,
    List<String>? additionalImages,
    String? personality,
    String? description,
    bool? isAvailable,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      isFemale: isFemale ?? this.isFemale,
      ownerId: ownerId ?? this.ownerId,
      imageUrl: imageUrl ?? this.imageUrl,
      additionalImages: additionalImages ?? this.additionalImages,
      personality: personality ?? this.personality,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 