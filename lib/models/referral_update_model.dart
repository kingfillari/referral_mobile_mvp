import 'dart:convert';

/// Tracks updates to a referral
class ReferralUpdateModel {
  final int id;
  final int referralId;
  final String status; // Updated status: Pending / Accepted / Rejected / Completed
  final String notes; // Notes from hospital staff or nurse
  final int updatedBy; // User ID who updated
  final DateTime updatedAt;

  ReferralUpdate({
    required this.id,
    required this.referralId,
    required this.status,
    required this.notes,
    required this.updatedBy,
    required this.updatedAt,
  });

  /// Convert JSON from API
  factory ReferralUpdate.fromJson(Map<String, dynamic> json) {
    return ReferralUpdate(
      id: json['id'] ?? 0,
      referralId: json['referral_id'] ?? 0,
      status: json['status'] ?? 'Pending',
      notes: json['notes'] ?? '',
      updatedBy: json['updated_by'] ?? 0,
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert to JSON for API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referral_id': referralId,
      'status': status,
      'notes': notes,
      'updated_by': updatedBy,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// SQLite mapping
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'referral_id': referralId,
      'status': status,
      'notes': notes,
      'updated_by': updatedBy,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ReferralUpdate.fromMap(Map<String, dynamic> map) {
    return ReferralUpdate(
      id: map['id'] ?? 0,
      referralId: map['referral_id'] ?? 0,
      status: map['status'] ?? 'Pending',
      notes: map['notes'] ?? '',
      updatedBy: map['updated_by'] ?? 0,
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// Short summary
  String displaySummary() => '$status - ${notes.length > 30 ? notes.substring(0, 30) + '...' : notes}';

  /// Copy with new values
  ReferralUpdate copyWith({
    int? id,
    int? referralId,
    String? status,
    String? notes,
    int? updatedBy,
    DateTime? updatedAt,
  }) {
    return ReferralUpdate(
      id: id ?? this.id,
      referralId: referralId ?? this.referralId,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'ReferralUpdate{id: $id, referralId: $referralId, status: $status, updatedBy: $updatedBy}';
  }
}