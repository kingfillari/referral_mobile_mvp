import 'package:flutter/material.dart';
import '../models/patient_model.dart';
import '../services/patient_service.dart';

class PatientRegistrationScreen extends StatelessWidget {

  final name = TextEditingController();
  final age = TextEditingController();

  final service = PatientService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Register Patient")),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Patient Name"),
            ),

            TextField(
              controller: age,
              decoration: InputDecoration(labelText: "Age"),
            ),

            ElevatedButton(
              child: Text("Save"),
              onPressed: () async {

                Patient patient = Patient(
                  name: name.text,
                  age: int.parse(age.text),
                  gender: "",
                  phone: "",
                  address: "",
                  notes: "",
                );

                await service.addPatient(patient);

                Navigator.pop(context);
              },
            )

          ],
        ),
      ),
    );
  }
}