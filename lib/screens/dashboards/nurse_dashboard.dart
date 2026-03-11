import 'package:flutter/material.dart';
import '../../services/sqlite_service.dart';
import '../../models/patient_model.dart';
import '../../widgets/patient_card.dart';
import '../../widgets/custom_button.dart';

class NurseDashboard extends StatefulWidget {
  final UserModel user;

  const NurseDashboard({super.key, required this.user});

  @override
  State<NurseDashboard> createState() => _NurseDashboardState();
}

class _NurseDashboardState extends State<NurseDashboard> {
  final SQLiteService _db = SQLiteService();
  List<PatientModel> _patients = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    setState(() {
      _loading = true;
    });
    final patients = await _db.getPatients();
    setState(() {
      _patients = patients;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nurse Dashboard')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadPatients,
              child: ListView.builder(
                itemCount: _patients.length,
                itemBuilder: (context, index) {
                  final patient = _patients[index];
                  return PatientCard(patient: patient);
                },
              ),
            ),
      floatingActionButton: CustomButton(
        text: 'Register Patient',
        onPressed: () {
          Navigator.pushNamed(context, '/patient-registration');
        },
      ),
    );
  }
}