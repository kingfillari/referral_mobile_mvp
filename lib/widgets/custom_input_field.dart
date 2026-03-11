import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final bool obscure;
  final int maxLines;
  final TextInputType? keyboardType;
  final IconData? icon;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
    this.maxLines = 1,
    this.keyboardType,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: controller,

      obscureText: obscure,

      keyboardType: keyboardType,

      maxLines: maxLines,

      decoration: InputDecoration(

        labelText: label,

        prefixIcon: icon != null
            ? Icon(icon)
            : null,

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

        contentPadding: const EdgeInsets.symmetric(
          horizontal:12,
          vertical:14,
        ),

      ),

    );

  }

}