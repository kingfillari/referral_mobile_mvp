import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {

  final AuthService _authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  UserModel? _user;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {

    final user = await _authService.getCurrentUser();

    setState(() {

      _user = user;

      if(user != null){
        _nameController.text = user.name;
        _emailController.text = user.email;
      }

      _loading = false;

    });

  }

  void _updateProfile(){

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Updated"))
    );

  }

  @override
  Widget build(BuildContext context) {

    if(_loading){
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("My Profile"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person,size:40),
            ),

            const SizedBox(height: 20),

            CustomInputField(
              controller: _nameController,
              label: "Full Name",
            ),

            const SizedBox(height: 10),

            CustomInputField(
              controller: _emailController,
              label: "Email",
            ),

            const SizedBox(height: 20),

            CustomButton(
              text: "Update Profile",
              onPressed: _updateProfile,
            )

          ],

        ),

      ),

    );

  }

}