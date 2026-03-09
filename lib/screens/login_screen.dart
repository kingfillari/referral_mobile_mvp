import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {

  final username = TextEditingController();
  final password = TextEditingController();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Login")),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: username,
              decoration: InputDecoration(labelText: "Username"),
            ),

            TextField(
              controller: password,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Login"),
              onPressed: () async {

                bool success = await authService.login(
                    username.text,
                    password.text);

                if(success){

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DashboardScreen()),
                  );
                }

              },
            )
          ],
        ),
      ),
    );
  }
}