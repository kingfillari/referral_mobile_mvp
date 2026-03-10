import 'dart:convert';
import '../config/roles.dart';

/// User model for authentication and role management
class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final int facilityId;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.facilityId,
    required this.token,
  });

  /// Convert JSON from API to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      facilityId: json['facility_id'] ?? 0,
      token: json['token'] ?? '',
    );
  }

  /// Convert User object to JSON for API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'facility_id': facilityId,
      'token': token,
    };
  }

  /// Convert User object to Map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'facility_id': facilityId,
      'token': token,
    };
  }

  /// Create User object from SQLite Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      facilityId: map['facility_id'] ?? 0,
      token: map['token'] ?? '',
    );
  }

  /// Helper: display name
  String displayName() => '$name (${roleLabel()})';

  /// Helper: human-readable role
  String roleLabel() {
    switch (role.toUpperCase()) {
      case UserRoles.nurse:
        return 'Nurse';
      case UserRoles.doctor:
        return 'Doctor';
      case UserRoles.hospitalStaff:
        return 'Hospital Staff';
      case UserRoles.admin:
        return 'Admin';
      default:
        return 'Unknown';
    }
  }

  /// Check role type
  bool get isAdmin => role.toUpperCase() == UserRoles.admin;
  bool get isNurse => role.toUpperCase() == UserRoles.nurse;
  bool get isDoctor => role.toUpperCase() == UserRoles.doctor;
  bool get isHospitalStaff => role.toUpperCase() == UserRoles.hospitalStaff;

  /// Encode object as JSON string
  String encode() => jsonEncode(toJson());

  /// Decode JSON string to User object
  static User decode(String userJson) => User.fromJson(jsonDecode(userJson));

  /// Create a copy with new values
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
    int? facilityId,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      facilityId: facilityId ?? this.facilityId,
      token: token ?? this.token,
    );
  }

  /// Validate email format
  bool get isValidEmail {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegex.hasMatch(email);
  }

  /// Validate password (for UI purposes, not stored here)
  static bool validatePassword(String password) {
    return password.length >= 6;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, role: $role, facilityId: $facilityId}';
  }
}