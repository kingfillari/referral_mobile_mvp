import 'package:flutter/material.dart';
import '../../models/referral_model.dart';
import '../../services/sqlite_service.dart';
import '../../widgets/custom_button.dart';

class ReferralDetailScreen extends StatefulWidget {
  final String referralId;
  const ReferralDetailScreen({super.key, required this.referralId});

  @override
  State<ReferralDetailScreen> createState() => _ReferralDetailScreenState();
}

class _ReferralDetailScreenState extends State<ReferralDetailScreen> {
  final SQLiteService _db = SQLiteService();
  ReferralModel? _referral;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadReferral();
  }

  Future<void> _loadReferral() async {
    setState(() => _loading = true);
    final referral = await _db.getReferralById(widget.referralId);
    setState(() {
      _referral = referral;
      _loading = false;
    });
  }

  Future<void> _updateStatus(String status) async {
    if (_referral == null) return;
    _referral!.status = status;
    await _db.updateReferral(_referral!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Referral marked as $status')),
    );
    _loadReferral();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_referral == null) return const Scaffold(body: Center(child: Text('Referral not found')));

    return Scaffold(
      appBar: AppBar(title: Text('Referral Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient ID: ${_referral!.patientId}'),
            Text('From: ${_referral!.referringFacility}'),
            Text('To: ${_referral!.receivingFacility}'),
            Text('Priority: ${_referral!.priority}'),
            const SizedBox(height: 10),
            Text('Summary: ${_referral!.clinicalSummary}'),
            const SizedBox(height: 20),
            Row(
              children: [
                CustomButton(
                    text: 'Accept',
                    onPressed: () => _updateStatus('Accepted')),
                const SizedBox(width: 10),
                CustomButton(
                    text: 'Reject',
                    onPressed: () => _updateStatus('Rejected')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}