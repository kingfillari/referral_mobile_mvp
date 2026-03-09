import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(ReferralApp());
}

class ReferralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Referral Management System',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}