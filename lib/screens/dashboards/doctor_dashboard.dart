import 'package:flutter/material.dart';
import '../../models/patient_model.dart';
import '../../models/referral_model.dart';
import '../../models/user_model.dart';
import '../../services/sqlite_service.dart';
import '../../services/sync_service.dart';
import '../../widgets/patient_card.dart';
import '../../widgets/referral_card.dart';
import '../../widgets/custom_button.dart';

class DoctorDashboard extends StatefulWidget {
  final UserModel user;
  const DoctorDashboard({super.key, required this.user});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  final SQLiteService _db = SQLiteService();
  final SyncService _sync = SyncService();

  List<PatientModel> _patients = [];
  List<ReferralModel> _referrals = [];
  bool _loadingPatients = true;
  bool _loadingReferrals = true;

  @override
  void initState() {
    super.initState();
    _loadPatients();
    _loadReferrals();
  }

  Future<void> _loadPatients() async {
    setState(() => _loadingPatients = true);
    final patients = await _db.getPatients();
    setState(() {
      _patients = patients;
      _loadingPatients = false;
    });
  }

  Future<void> _loadReferrals() async {
    setState(() => _loadingReferrals = true);
    final referrals = await _db.getReferrals();
    setState(() {
      _referrals = referrals;
      _loadingReferrals = false;
    });
  }

  /// Manual sync
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

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadPatients();
          await _loadReferrals();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Sync Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _syncAll,
                  child: const Text('Sync Now'),
                ),
              ),

              _buildSection(
                'My Patients',
                _loadingPatients
                    ? [const Center(child: CircularProgressIndicator())]
                    : _patients.map((p) => PatientCard(patient: p)).toList(),
              ),
              _buildSection(
                'Referrals to Review',
                _loadingReferrals
                    ? [const Center(child: CircularProgressIndicator())]
                    : _referrals
                        .map((r) => ReferralCard(
                              referral: r,
                              onAccept: () async {
                                await _db.updateReferralStatus(r.id, 'Accepted');
                                _loadReferrals();
                              },
                              onReject: () async {
                                await _db.updateReferralStatus(r.id, 'Rejected');
                                _loadReferrals();
                              },
                            ))
                        .toList(),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Create Referral',
                onPressed: () {
                  Navigator.pushNamed(context, '/create-referral');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
