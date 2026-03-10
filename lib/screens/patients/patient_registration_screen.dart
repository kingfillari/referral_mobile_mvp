import 'package:flutter/material.dart';
import '../../models/patient_model.dart';
import '../../services/sqlite_service.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_button.dart';
import '../../utils/validators.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final SQLiteService _db = SQLiteService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mrnController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool _loading = false;

  Future<void> _registerPatient() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    final patient = PatientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text),
      sex: _sexController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      mrn: _mrnController.text,
      medicalNotes: _notesController.text,
      createdAt: DateTime.now(),
    );

    await _db.insertPatient(patient);

    setState(() {
      _loading = false;
      _nameController.clear();
      _ageController.clear();
      _sexController.clear();
      _phoneController.clear();
      _addressController.clear();
      _mrnController.clear();
      _notesController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Patient registered successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Patient')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInputField(
                controller: _nameController,
                label: 'Full Name',
                validator: Validators.required,
              ),
              CustomInputField(
                controller: _ageController,
                label: 'Age',
                keyboardType: TextInputType.number,
                validator: Validators.ageValidator,
              ),
              CustomInputField(
                controller: _sexController,
                label: 'Sex (M/F)',
                validator: Validators.required,
              ),
              CustomInputField(
                controller: _phoneController,
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: Validators.phoneValidator,
              ),
              CustomInputField(
                controller: _addressController,
                label: 'Address',
                validator: Validators.required,
              ),
              CustomInputField(
                controller: _mrnController,
                label: 'Medical Record Number',
                validator: Validators.required,
              ),
              CustomInputField(
                controller: _notesController,
                label: 'Medical Notes',
                maxLines: 4,
                validator: (_) => null,
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: 'Register Patient',
                      onPressed: _registerPatient,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}