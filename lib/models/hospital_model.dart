import 'dart:convert';

/// Hospital / Facility model
class Hospital {
  final int id;
  final String name;
  final String type; // Referral, General, Specialized
  final String location;
  final String services;
  final String status; // Active / Inactive
  final DateTime createdAt;

  Hospital({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.services,
    required this.status,
    required this.createdAt,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? 'General',
      location: json['location'] ?? '',
      services: json['services'] ?? '',
      status: json['status'] ?? 'Active',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'location': location,
      'services': services,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'location': location,
      'services': services,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Hospital.fromMap(Map<String, dynamic> map) {
    return Hospital(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      type: map['type'] ?? 'General',
      location: map['location'] ?? '',
      services: map['services'] ?? '',
      status: map['status'] ?? 'Active',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  String displayLabel() => '$name - $type';

  bool get isActive => status.toLowerCase() == 'active';
  bool get isInactive => status.toLowerCase() == 'inactive';

  Hospital copyWith({
    int? id,
    String? name,
    String? type,
    String? location,
    String? services,
    String? status,
    DateTime? createdAt,
  }) {
    return Hospital(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      location: location ?? this.location,
      services: services ?? this.services,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Hospital{id: $id, name: $name, type: $type, status: $status}';
  }
}