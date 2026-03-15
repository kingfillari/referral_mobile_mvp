import 'dart:convert';

/// Patient model for hospital referral system
class PatientModel {
  final int id;
  final String name;
  final int age;
  final String sex;
  final String phone;
  final String address;
  final String mrn; // Medical Record Number
  final int tenantId;
  final DateTime createdAt;
  final String status; // Added
  final String condition; // Added

  PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.phone,
    required this.address,
    required this.mrn,
    required this.tenantId,
    required this.createdAt,
    this.status = 'Pending', // default
    this.condition = '', // default
  });

  /// Convert JSON from API to Patient
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      sex: json['sex'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      mrn: json['mrn'] ?? '',
      tenantId: json['tenantId'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'Pending',
      condition: json['condition'] ?? '',
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
      'tenantId': tenantId,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'condition': condition,
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
      'tenantId': tenantId,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'condition': condition,
    };
  }

  /// Create Patient from SQLite Map
  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      sex: map['sex'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      mrn: map['mrn'] ?? '',
      tenantId: map['tenantId'] ?? 0,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      status: map['status'] ?? 'Pending',
      condition: map['condition'] ?? '',
    );
  }

  /// Validate phone number
  bool get isValidPhone => RegExp(r'^\+?\d{7,15}$').hasMatch(phone);

  /// Short display for lists
  String displayLabel() => '$name, MRN: $mrn';

  /// Copy with new values
  PatientModel copyWith({
    int? id,
    String? name,
    int? age,
    String? sex,
    String? phone,
    String? address,
    String? mrn,
    int? tenantId,
    DateTime? createdAt,
    String? status,
    String? condition,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      mrn: mrn ?? this.mrn,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      condition: condition ?? this.condition,
    );
  }

  @override
  String toString() {
    return 'PatientModel{id: $id, name: $name, mrn: $mrn, age: $age, sex: $sex}';
  }
}