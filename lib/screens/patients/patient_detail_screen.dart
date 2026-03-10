import 'package:flutter/material.dart';
import '../../models/patient_model.dart';
import '../../services/sqlite_service.dart';
import '../../widgets/custom_button.dart';

class PatientDetailScreen extends StatefulWidget {
  final String patientId;
  const PatientDetailScreen({super.key, required this.patientId});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  final SQLiteService _db = SQLiteService();
  PatientModel? _patient;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPatient();
  }

  Future<void> _loadPatient() async {
    setState(() => _loading = true);
    final patient = await _db.getPatientById(widget.patientId);
    setState(() {
      _patient = patient;
      _loading = false;
    });
  }

  Future<void> _deletePatient() async {
    if (_patient == null) return;
    await _db.deletePatient(_patient!.id);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Patient deleted')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    if (_patient == null) return const Scaffold(body: Center(child: Text('Patient not found')));

    return Scaffold(
      appBar: AppBar(title: Text(_patient!.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_patient!.name}'),
            Text('Age: ${_patient!.age}'),
            Text('Sex: ${_patient!.sex}'),
            Text('Phone: ${_patient!.phone}'),
            Text('Address: ${_patient!.address}'),
            Text('MRN: ${_patient!.mrn}'),
            const SizedBox(height: 10),
            Text('Medical Notes: ${_patient!.medicalNotes}'),
            const SizedBox(height: 20),
            CustomButton(text: 'Delete Patient', onPressed: _deletePatient),
          ],
        ),
      ),
    );
  }
}