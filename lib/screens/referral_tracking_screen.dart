import 'package:flutter/material.dart';
import '../services/database_service.dart';

class ReferralTrackingScreen extends StatefulWidget {
  @override
  _ReferralTrackingScreenState createState() => _ReferralTrackingScreenState();
}

class _ReferralTrackingScreenState extends State<ReferralTrackingScreen> {

  List referrals = [];

  loadReferrals() async {

    final db = await DatabaseService().database;

    final data = await db.query("referrals");

    setState(() {
      referrals = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadReferrals();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Referral Tracking")),

      body: ListView.builder(
        itemCount: referrals.length,
        itemBuilder: (context, index){

          final r = referrals[index];

          return ListTile(
            title: Text("Hospital: ${r['hospital']}"),
            subtitle: Text("Status: ${r['status']}"),
          );
        },
      ),
    );
  }
}