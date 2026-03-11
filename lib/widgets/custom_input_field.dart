import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool obscureText;
  final int maxLines;
  final TextInputType? keyboardType;
  final IconData? icon;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.controller,
    this.labelText,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}