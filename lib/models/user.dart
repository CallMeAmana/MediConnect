import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserType type;
  final String? profileImage;
  final String? specialization; // For doctors
  final List<String>? qualifications; // For doctors
  final DateTime createdAt;
  final DateTime lastActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    this.profileImage,
    this.specialization,
    this.qualifications,
    DateTime? createdAt,
    DateTime? lastActive,
  }) :
        this.createdAt = createdAt ?? DateTime.now(),
        this.lastActive = lastActive ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'],
      email: json['email'],
      password: json['password'],
      type: UserType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => UserType.patient,
      ),
      profileImage: json['profileImage'],
      specialization: json['specialization'],
      qualifications: json['qualifications'] != null
          ? List<String>.from(json['qualifications'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      lastActive: json['lastActive'] != null
          ? DateTime.parse(json['lastActive'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type.toString().split('.').last,
      'profileImage': profileImage,
      'specialization': specialization,
      'qualifications': qualifications,
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    UserType? type,
    String? profileImage,
    String? specialization,
    List<String>? qualifications,
    DateTime? createdAt,
    DateTime? lastActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      profileImage: profileImage ?? this.profileImage,
      specialization: specialization ?? this.specialization,
      qualifications: qualifications ?? this.qualifications,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum UserType {
  patient,
  doctor,
}