import 'package:flutter/material.dart';
import '../../services/sqlite_service.dart';
import '../../services/sync_service.dart';
import '../../models/patient_model.dart';
import '../../models/user_model.dart'; 
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
  final SyncService _sync = SyncService();

  List<PatientModel> _patients = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    setState(() => _loading = true);
    final patients = await _db.getPatients();
    setState(() {
      _patients = patients;
      _loading = false;
    });
  }

  Future<void> _syncAll() async {
    try {
      await _sync.syncAll(tenantId: widget.user.tenantId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync completed!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sync failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nurse Dashboard')),
      body: RefreshIndicator(
        onRefresh: _loadPatients,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _syncAll,
                  child: const Text('Sync Now'),
                ),
              ),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _patients.length,
                      itemBuilder: (context, index) {
                        final patient = _patients[index];
                        return PatientCard(patient: patient);
                      },
                    ),
            ],
          ),
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
