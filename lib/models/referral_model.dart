import 'dart:convert';
import 'patient_model.dart';
import 'user_model.dart';

/// Referral model representing patient referral records
class Referral {
  final int id;
  final int patientId;
  final int referringFacility;
  final int receivingFacility;
  final String priority; // Routine / Urgent / Emergency
  final String clinicalSummary;
  final String status; // Pending / Accepted / Rejected / Completed
  final DateTime createdAt;
  final int createdBy; // User ID who created

  Referral({
    required this.id,
    required this.patientId,
    required this.referringFacility,
    required this.receivingFacility,
    required this.priority,
    required this.clinicalSummary,
    required this.status,
    required this.createdAt,
    required this.createdBy,
  });

  /// Convert JSON from API
  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      referringFacility: json['referring_facility'] ?? 0,
      receivingFacility: json['receiving_facility'] ?? 0,
      priority: json['priority'] ?? 'Routine',
      clinicalSummary: json['clinical_summary'] ?? '',
      status: json['status'] ?? 'Pending',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      createdBy: json['created_by'] ?? 0,
    );
  }

  /// Convert Referral to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'referring_facility': referringFacility,
      'receiving_facility': receivingFacility,
      'priority': priority,
      'clinical_summary': clinicalSummary,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
    };
  }

  /// Convert Referral to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_id': patientId,
      'referring_facility': referringFacility,
      'receiving_facility': receivingFacility,
      'priority': priority,
      'clinical_summary': clinicalSummary,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
    };
  }

  /// Create Referral from SQLite Map
  factory Referral.fromMap(Map<String, dynamic> map) {
    return Referral(
      id: map['id'] ?? 0,
      patientId: map['patient_id'] ?? 0,
      referringFacility: map['referring_facility'] ?? 0,
      receivingFacility: map['receiving_facility'] ?? 0,
      priority: map['priority'] ?? 'Routine',
      clinicalSummary: map['clinical_summary'] ?? '',
      status: map['status'] ?? 'Pending',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      createdBy: map['created_by'] ?? 0,
    );
  }

  /// Helper: check if referral is urgent
  bool get isUrgent => priority.toLowerCase() == 'urgent';
  bool get isEmergency => priority.toLowerCase() == 'emergency';
  bool get isRoutine => priority.toLowerCase() == 'routine';

  /// Short summary for lists
  String displaySummary(String patientName) =>
      'Referral for $patientName - $priority - $status';

  /// Copy with new values
  Referral copyWith({
    int? id,
    int? patientId,
    int? referringFacility,
    int? receivingFacility,
    String? priority,
    String? clinicalSummary,
    String? status,
    DateTime? createdAt,
    int? createdBy,
  }) {
    return Referral(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      referringFacility: referringFacility ?? this.referringFacility,
      receivingFacility: receivingFacility ?? this.receivingFacility,
      priority: priority ?? this.priority,
      clinicalSummary: clinicalSummary ?? this.clinicalSummary,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  @override
  String toString() {
    return 'Referral{id: $id, patientId: $patientId, priority: $priority, status: $status}';
  }
}