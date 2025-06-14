class Pet {
  final String id;
  final String name;
  final String breed;
  final String age;
  final String weight;
  final bool isFemale;
  final String imageUrl;
  final List<String> additionalImages;
  final String personality;
  final String description;
  final String ownerId;
  final bool isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.weight,
    required this.isFemale,
    required this.imageUrl,
    this.additionalImages = const [],
    required this.personality,
    required this.description,
    required this.ownerId,
    this.isAvailable = true,
    this.createdAt,
    this.updatedAt,
  });

  String get genderText => isFemale ? 'Female' : 'Male';

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['_id']?.toString() ?? map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      breed: map['breed'] ?? '',
      age: map['age']?.toString() ?? '',
      weight: map['weight']?.toString() ?? '',
      isFemale: map['isFemale'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
      additionalImages: List<String>.from(map['additionalImages'] ?? []),
      personality: map['personality'] ?? '',
      description: map['description'] ?? '',
      ownerId: map['ownerId']?.toString() ?? '',
      isAvailable: map['isAvailable'] ?? true,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'age': age,
      'weight': weight,
      'isFemale': isFemale,
      'imageUrl': imageUrl,
      'additionalImages': additionalImages,
      'personality': personality,
      'description': description,
      'ownerId': ownerId,
      'isAvailable': isAvailable,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Pet copyWith({
    String? id,
    String? name,
    String? breed,
    String? age,
    String? weight,
    bool? isFemale,
    String? imageUrl,
    List<String>? additionalImages,
    String? personality,
    String? description,
    String? ownerId,
    bool? isAvailable,
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
      imageUrl: imageUrl ?? this.imageUrl,
      additionalImages: additionalImages ?? this.additionalImages,
      personality: personality ?? this.personality,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
