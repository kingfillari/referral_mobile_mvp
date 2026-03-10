import 'package:flutter/material.dart';
import '../../models/patient_model.dart';
import '../../services/sqlite_service.dart';
import '../../widgets/patient_card.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final SQLiteService _db = SQLiteService();
  List<PatientModel> _patients = [];
  bool _loading = true;
  String _searchTerm = '';

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

  List<PatientModel> _filterPatients() {
    if (_searchTerm.isEmpty) return _patients;
    return _patients
        .where((p) =>
            p.name.toLowerCase().contains(_searchTerm.toLowerCase()) ||
            p.mrn.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filterPatients();

    return Scaffold(
      appBar: AppBar(title: const Text('Patient List')),
      body: RefreshIndicator(
        onRefresh: _loadPatients,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search by Name or MRN',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) {
                  setState(() => _searchTerm = v);
                },
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : filtered.isEmpty
                      ? const Center(child: Text('No patients found'))
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) =>
                              PatientCard(patient: filtered[index]),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/patient-registration')
              .then((_) => _loadPatients());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}