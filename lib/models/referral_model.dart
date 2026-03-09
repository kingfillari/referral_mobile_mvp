class Referral {

  int? id;
  int patientId;
  String hospital;
  String priority;
  String clinicalNotes;
  String status;

  Referral({
    this.id,
    required this.patientId,
    required this.hospital,
    required this.priority,
    required this.clinicalNotes,
    required this.status,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'patient_id': patientId,
      'hospital': hospital,
      'priority': priority,
      'clinical_notes': clinicalNotes,
      'status': status,
      'synced': 0
    };
  }
}