class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? bio;
  final String? location;
  final String? profileImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.bio,
    this.location,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  factory User.fromMap(Map<String, dynamic> map) {
    print('👤 [USER] Parsing user data: $map');

    final user = User(
      id: map['_id']?.toString() ?? map['id']?.toString() ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      bio: map['bio'],
      location: map['location'],
      profileImageUrl: map['profileImageUrl'],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'].toString())
          : null,
    );

    print(
        '👤 [USER] Parsed user: ${user.firstName} ${user.lastName} (${user.email})');
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'bio': bio,
      'location': location,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? bio,
    String? location,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
