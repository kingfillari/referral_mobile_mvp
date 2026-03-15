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
  final SyncService _syncService = SyncService();

  List<PatientModel> _patients = [];
  bool _loading = true;
  bool _syncing = false;

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

  Future<void> _syncData() async {
    setState(() => _syncing = true);
    try {
      final tenantId = widget.user.tenantId ?? 1;
await syncService.syncAll(tenantId: tenantId);      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync completed!')),
      );
      _loadPatients();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sync failed: $e')),
      );
    } finally {
      setState(() => _syncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse Dashboard'),
        actions: [
          IconButton(
            icon: _syncing
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.sync),
onPressed: _syncing
    ? null
    : () async {
        await _syncData();
      },          ),
        ],
      ),
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            text: 'Register Patient',
            onPressed: () {
              Navigator.pushNamed(context, '/patient-registration');
            },
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: _syncing ? 'Syncing...' : 'Sync Now',
onPressed: _syncing
    ? null
    : () async {
        await _syncData();
      },          ),
        ],
      ),
    );
  }
}
