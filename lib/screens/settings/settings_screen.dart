import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {

  final AuthService _authService = AuthService();

  bool notifications = true;
  bool darkMode = false;

  void _logout() async {

    await _authService.logout();

    if(!mounted) return;

    Navigator.pushReplacementNamed(context,"/login");

  }

  Widget _settingTile({

    required String title,
    required IconData icon,
    required Widget trailing

  }){

    return ListTile(

      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: ListView(

        children: [

          const SizedBox(height: 10),

          _settingTile(
            title: "Notifications",
            icon: Icons.notifications,
            trailing: Switch(
              value: notifications,
              onChanged: (value){
                setState(() {
                  notifications = value;
                });
              },
            ),
          ),

          _settingTile(
            title: "Dark Mode",
            icon: Icons.dark_mode,
            trailing: Switch(
              value: darkMode,
              onChanged: (value){
                setState(() {
                  darkMode = value;
                });
              },
            ),
          ),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("App Version"),
            subtitle: const Text("1.0.0 MVP"),
          ),

          ListTile(
            leading: const Icon(Icons.policy),
            title: const Text("Privacy Policy"),
            onTap: (){
              showDialog(
                context: context,
                builder: (context){

                  return const AlertDialog(
                    title: Text("Privacy Policy"),
                    content: Text("RMS protects patient referral data."),
                  );

                },
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout,color:Colors.red),
            title: const Text("Logout",style: TextStyle(color: Colors.red)),
            onTap: _logout,
          ),

          const SizedBox(height:40)

        ],

      ),

    );

  }

}