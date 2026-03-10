import 'package:flutter/material.dart';
import '../../models/referral_model.dart';
import '../../services/sqlite_service.dart';
import '../../widgets/referral_card.dart';

class ReferralListScreen extends StatefulWidget {
  const ReferralListScreen({super.key});

  @override
  State<ReferralListScreen> createState() => _ReferralListScreenState();
}

class _ReferralListScreenState extends State<ReferralListScreen> {
  final SQLiteService _db = SQLiteService();
  List<ReferralModel> _referrals = [];
  bool _loading = true;
  String _filterStatus = 'All';

  @override
  void initState() {
    super.initState();
    _loadReferrals();
  }

  Future<void> _loadReferrals() async {
    setState(() => _loading = true);
    final referrals = await _db.getReferrals();
    setState(() {
      _referrals = referrals;
      _loading = false;
    });
  }

  List<ReferralModel> _filteredReferrals() {
    if (_filterStatus == 'All') return _referrals;
    return _referrals.where((r) => r.status == _filterStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredReferrals();

    return Scaffold(
      appBar: AppBar(title: const Text('Referrals')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: _filterStatus,
              decoration: const InputDecoration(labelText: 'Filter by Status'),
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All')),
                DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                DropdownMenuItem(value: 'Accepted', child: Text('Accepted')),
                DropdownMenuItem(value: 'Rejected', child: Text('Rejected')),
              ],
              onChanged: (v) => setState(() => _filterStatus = v!),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? const Center(child: Text('No referrals found'))
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) =>
                            ReferralCard(referral: filtered[index]),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-referral')
              .then((_) => _loadReferrals());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}