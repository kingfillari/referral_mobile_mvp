import 'package:flutter/material.dart';
import '../../models/referral_model.dart';
import '../../models/patient_model.dart';
import '../../models/hospital_model.dart';
import '../../services/sqlite_service.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_button.dart';
import '../../utils/validators.dart';

class CreateReferralScreen extends StatefulWidget {
  const CreateReferralScreen({super.key});

  @override
  State<CreateReferralScreen> createState() => _CreateReferralScreenState();
}

class _CreateReferralScreenState extends State<CreateReferralScreen> {
  final _formKey = GlobalKey<FormState>();
  final SQLiteService _db = SQLiteService();

  PatientModel? _selectedPatient;
  HospitalModel? _selectedHospital;
  final TextEditingController _summaryController = TextEditingController();
  String _priority = 'Routine';
  bool _loading = false;

  List<PatientModel> _patients = [];
  List<HospitalModel> _hospitals = [];

  @override
  void initState() {
    super.initState();
    _loadPatientsAndHospitals();
  }

  Future<void> _loadPatientsAndHospitals() async {
    final patients = await _db.getPatients();
    final hospitals = await _db.getHospitals();
    setState(() {
      _patients = patients;
      _hospitals = hospitals;
    });
  }

  Future<void> _submitReferral() async {
    if (!_formKey.currentState!.validate() || _selectedPatient == null || _selectedHospital == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select patient, hospital and fill the summary'),
      ));
      return;
    }

    setState(() {
      _loading = true;
    });

    final referral = ReferralModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientId: _selectedPatient!.id,
      referringFacility: 'Local Clinic', // can be dynamic
      receivingFacility: _selectedHospital!.name,
      priority: _priority,
      clinicalSummary: _summaryController.text.trim(),
      status: 'Pending',
      createdAt: DateTime.now(),
    );

    await _db.insertReferral(referral);

    setState(() {
      _loading = false;
      _selectedPatient = null;
      _selectedHospital = null;
      _summaryController.clear();
      _priority = 'Routine';
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Referral submitted successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Referral')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<PatientModel>(
                value: _selectedPatient,
                decoration: const InputDecoration(labelText: 'Select Patient'),
                items: _patients.map((p) {
                  return DropdownMenuItem(value: p, child: Text(p.name));
                }).toList(),
                onChanged: (p) => setState(() => _selectedPatient = p),
                validator: (_) => _selectedPatient == null ? 'Select a patient' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<HospitalModel>(
                value: _selectedHospital,
                decoration: const InputDecoration(labelText: 'Select Hospital'),
                items: _hospitals.map((h) {
                  return DropdownMenuItem(value: h, child: Text(h.name));
                }).toList(),
                onChanged: (h) => setState(() => _selectedHospital = h),
                validator: (_) => _selectedHospital == null ? 'Select a hospital' : null,
              ),
              const SizedBox(height: 10),
              CustomInputField(
                controller: _summaryController,
                label: 'Clinical Summary',
                maxLines: 5,
                validator: Validators.required,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: const [
                  DropdownMenuItem(value: 'Routine', child: Text('Routine')),
                  DropdownMenuItem(value: 'Urgent', child: Text('Urgent')),
                  DropdownMenuItem(value: 'Emergency', child: Text('Emergency')),
                ],
                onChanged: (v) => setState(() => _priority = v!),
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: 'Submit Referral',
                      onPressed: _submitReferral,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}