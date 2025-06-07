import 'package:mongo_dart/mongo_dart.dart';

class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String? bio;
  final String? profileImageUrl;
  final String? location;
  final bool isOnline;
  final DateTime? lastActive;
  final List<String> petIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.bio,
    this.profileImageUrl,
    this.location,
    this.isOnline = false,
    this.lastActive,
    this.petIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from MongoDB document
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id']?.toString(),
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'],
      profileImageUrl: map['profileImageUrl'],
      location: map['location'],
      isOnline: map['isOnline'] ?? false,
      lastActive: map['lastActive']?.toDate(),
      petIds: List<String>.from(map['petIds'] ?? []),
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: map['updatedAt']?.toDate() ?? DateTime.now(),
    );
  }

  // Convert to MongoDB document
  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': ObjectId.parse(id!),
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'location': location,
      'isOnline': isOnline,
      'lastActive': lastActive,
      'petIds': petIds,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String get fullName => '$firstName $lastName';

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? bio,
    String? profileImageUrl,
    String? location,
    bool? isOnline,
    DateTime? lastActive,
    List<String>? petIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      location: location ?? this.location,
      isOnline: isOnline ?? this.isOnline,
      lastActive: lastActive ?? this.lastActive,
      petIds: petIds ?? this.petIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
