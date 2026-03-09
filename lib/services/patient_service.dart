import '../models/patient_model.dart';
import 'database_service.dart';

class PatientService {

  final dbService = DatabaseService();

  Future addPatient(Patient patient) async {

    final db = await dbService.database;

    await db.insert("patients", patient.toMap());
  }

}