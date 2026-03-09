import 'package:flutter/material.dart';
import 'patient_registration_screen.dart';
import 'create_referral_screen.dart';
import 'referral_tracking_screen.dart';

class DashboardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Referral Dashboard")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            ElevatedButton(
              child: Text("Register Patient"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PatientRegistrationScreen(),
                  ),
                );
              },
            ),

            ElevatedButton(
              child: Text("Create Referral"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateReferralScreen(),
                  ),
                );
              },
            ),

            ElevatedButton(
              child: Text("Track Referrals"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReferralTrackingScreen(),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}