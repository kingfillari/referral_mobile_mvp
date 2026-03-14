import 'package:flutter/material.dart';
import '../../models/referral_model.dart';
import '../../models/user_model.dart'; 
import '../../services/sqlite_service.dart';
import '../../widgets/referral_card.dart';
import '../../widgets/custom_button.dart';

class HospitalDashboard extends StatefulWidget {
    final UserModel user;

  const HospitalDashboard({super.key, required this.user});

  @override
  State<HospitalDashboard> createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  final SQLiteService _db = SQLiteService();
  List<ReferralModel> _referrals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadReferrals();
  }

  Future<void> _loadReferrals() async {
    setState(() {
      _loading = true;
    });
    final referrals = await _db.getReferrals();
    setState(() {
      _referrals = referrals;
      _loading = false;
    });
  }

  Widget _buildReferralList() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_referrals.isEmpty) {
      return const Center(child: Text('No referrals pending'));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _referrals.length,
      itemBuilder: (context, index) {
        final r = _referrals[index];
        return ReferralCard(
          referral: r,
          onAccept: () async {
            await _db.updateReferralStatus(r.id, 'Accepted');
            _loadReferrals();
          },
          onReject: () async {
            await _db.updateReferralStatus(r.id, 'Rejected');
            _loadReferrals();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hospital Dashboard')),
      body: RefreshIndicator(
        onRefresh: _loadReferrals,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Pending Referrals',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              _buildReferralList(),
              const SizedBox(height: 20),
              CustomButton(
                text: 'View All Referrals',
                onPressed: () {
                  Navigator.pushNamed(context, '/referral-list');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}