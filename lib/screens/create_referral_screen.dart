import 'package:flutter/material.dart';
import '../models/referral_model.dart';
import '../services/referral_service.dart';

class CreateReferralScreen extends StatelessWidget {

  final patientId = TextEditingController();
  final hospital = TextEditingController();
  final notes = TextEditingController();

  final service = ReferralService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Create Referral")),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: patientId,
              decoration: InputDecoration(labelText: "Patient ID"),
            ),

            TextField(
              controller: hospital,
              decoration: InputDecoration(labelText: "Hospital"),
            ),

            TextField(
              controller: notes,
              decoration: InputDecoration(labelText: "Clinical Notes"),
            ),

            ElevatedButton(
              child: Text("Submit Referral"),

              onPressed: () async {

                Referral referral = Referral(
                  patientId: int.parse(patientId.text),
                  hospital: hospital.text,
                  priority: "Routine",
                  clinicalNotes: notes.text,
                  status: "Pending",
                );

                await service.createReferral(referral);

                Navigator.pop(context);
              },
            )

          ],
        ),
      ),
    );
  }
}