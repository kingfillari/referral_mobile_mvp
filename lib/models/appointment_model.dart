import 'dart:convert';

/// Appointment model for referred patients
class AppointmentModel {
  final int id;
  final int referralId;
  final int patientId;
  final int doctorId;
  final DateTime appointmentDate;
  final String department;
  final String notes;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.referralId,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.department,
    required this.notes,
    required this.createdAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? 0,
      referralId: json['referral_id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      doctorId: json['doctor_id'] ?? 0,
      appointmentDate: DateTime.tryParse(json['appointment_date'] ?? '') ?? DateTime.now(),
      department: json['department'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referral_id': referralId,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_date': appointmentDate.toIso8601String(),
      'department': department,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'referral_id': referralId,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_date': appointmentDate.toIso8601String(),
      'department': department,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] ?? 0,
      referralId: map['referral_id'] ?? 0,
      patientId: map['patient_id'] ?? 0,
      doctorId: map['doctor_id'] ?? 0,
      appointmentDate: DateTime.tryParse(map['appointment_date'] ?? '') ?? DateTime.now(),
      department: map['department'] ?? '',
      notes: map['notes'] ?? '',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// Check if appointment is in the past
  bool get isPast => appointmentDate.isBefore(DateTime.now());

  /// Short label
  String displayLabel(String patientName) => '$patientName - $department on ${appointmentDate.toLocal()}';

  /// Copy with new values
  AppointmentModel copyWith({
    int? id,
    int? referralId,
    int? patientId,
    int? doctorId,
    DateTime? appointmentDate,
    String? department,
    String? notes,
    DateTime? createdAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      referralId: referralId ?? this.referralId,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      department: department ?? this.department,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'AppointmentModel{id: $id, patientId: $patientId, doctorId: $doctorId, date: $appointmentDate}';
  }
}