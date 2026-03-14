import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/role_service.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_button.dart';
import '../../utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  final AuthService _authService = AuthService();
  final RoleService _roleService = RoleService();

  bool _loading = false;
  String? _error;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final user = await _authService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: _roleController.text.trim(),
      );

      if (user != null) {
        final route = _authService.getDashboardRoute(user);
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, route);
      } else {
        setState(() {
          _error = 'Registration failed. Please check your data.';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roles = _roleService.getAllRoles();
    _roleController.text = roles.first; // default role

    return Scaffold(
      appBar: AppBar(title: const Text('RMS Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign up to start managing referrals',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomInputField(
                controller: _nameController,
                labelText: 'Full Name',
                validator: Validators.validateName,
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: _emailController,
                labelText: 'Email',
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: roles.first,
                items: roles
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) {
                  _roleController.text = value!;
                },
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              if (_error != null)
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              CustomButton(
                text: _loading ? 'Registering...' : 'Register',
                loading: _loading,
                onPressed: _register,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}