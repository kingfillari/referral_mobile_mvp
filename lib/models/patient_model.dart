import 'dart:convert';

/// Patient model for hospital referral system
class Patient {
  final int id;
  final String name;
  final int age;
  final String sex;
  final String phone;
  final String address;
  final String mrn; // Medical Record Number
  final DateTime createdAt;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.phone,
    required this.address,
    required this.mrn,
    required this.createdAt,
  });

  /// Convert JSON from API to Patient
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      sex: json['sex'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      mrn: json['mrn'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert Patient to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
      'phone': phone,
      'address': address,
      'mrn': mrn,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Convert Patient to SQLite Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
      'phone': phone,
      'address': address,
      'mrn': mrn,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Create Patient from SQLite Map
  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      sex: map['sex'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      mrn: map['mrn'] ?? '',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// Validate phone number
  bool get isValidPhone => RegExp(r'^\+?\d{7,15}$').hasMatch(phone);

  /// Short display for lists
  String displayLabel() => '$name, MRN: $mrn';

  /// Copy with new values
  Patient copyWith({
    int? id,
    String? name,
    int? age,
    String? sex,
    String? phone,
    String? address,
    String? mrn,
    DateTime? createdAt,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      mrn: mrn ?? this.mrn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Patient{id: $id, name: $name, mrn: $mrn, age: $age, sex: $sex}';
  }
}