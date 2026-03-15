import 'package:flutter/material.dart';
import '../../services/sqlite_service.dart';
import '../../services/sync_service.dart';
import '../../models/user_model.dart';
import '../../models/hospital_model.dart';
import '../../widgets/custom_button.dart';

class AdminDashboard extends StatefulWidget {
  final UserModel user;
  const AdminDashboard({super.key, required this.user});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final SQLiteService _db = SQLiteService();
  final SyncService _syncService = SyncService();

  List<UserModel> _users = [];
  List<HospitalModel> _hospitals = [];
  bool _loadingUsers = true;
  bool _loadingHospitals = true;
  bool _syncing = false; // New: sync state

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadHospitals();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _loadingUsers = true;
    });
    final users = await _db.getUsers();
    setState(() {
      _users = users;
      _loadingUsers = false;
    });
  }

  Future<void> _loadHospitals() async {
    setState(() {
      _loadingHospitals = true;
    });
    final hospitals = await _db.getHospitals();
    setState(() {
      _hospitals = hospitals;
      _loadingHospitals = false;
    });
  }

  Future<void> _syncData() async {
    setState(() => _syncing = true);
    try {
      final tenantId = widget.user.tenantId ?? 1; // use tenantId from user
await syncService.syncAll(tenantId: tenantId);      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync completed!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sync failed: $e')),
      );
    } finally {
      setState(() => _syncing = false);
    }
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
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
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: _syncing
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.sync),
onPressed: _syncing
    ? null
    : () async {
        await _syncData();
      },            tooltip: 'Sync Data',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection(
              'Users Management',
              _loadingUsers
                  ? [const CircularProgressIndicator()]
                  : _users
                      .map((u) => ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(u.name),
                            subtitle: Text(u.role),
                          ))
                      .toList(),
            ),
            _buildSection(
              'Facilities Management',
              _loadingHospitals
                  ? [const CircularProgressIndicator()]
                  : _hospitals
                      .map((h) => ListTile(
                            leading: const Icon(Icons.local_hospital),
                            title: Text(h.name),
                            subtitle: Text(h.location),
                          ))
                      .toList(),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Add User',
              onPressed: () {
                Navigator.pushNamed(context, '/user-management');
              },
            ),
            CustomButton(
              text: 'Add Facility',
              onPressed: () {
                Navigator.pushNamed(context, '/facility-management');
              },
            ),
            const SizedBox(height: 20),
            // Manual sync button in body
            CustomButton(
              text: _syncing ? 'Syncing...' : 'Sync Now',
onPressed: _syncing
    ? null
    : () async {
        await _syncData();
      },            ),
          ],
        ),
      ),
    );
  }
}