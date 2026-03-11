import 'package:flutter/material.dart';

class Validators {

  static String? validateEmail(String? value) {

    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regex.hasMatch(value)) {
      return "Invalid email format";
    }

    return null;

  }

  static String? validatePassword(String? value) {

    if (value == null || value.isEmpty) {
      return "Password required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;

  }

  static String? validateName(String? value) {

    if (value == null || value.trim().isEmpty) {
      return "Name cannot be empty";
    }

    if (value.length < 3) {
      return "Name too short";
    }

    return null;

  }

  static String? validatePhone(String? value) {

    if (value == null || value.isEmpty) {
      return "Phone number required";
    }

    final regex = RegExp(r'^\+?[0-9]{9,15}$');

    if (!regex.hasMatch(value)) {
      return "Invalid phone number";
    }

    return null;

  }

  static String? validateAge(String? value) {

    if (value == null || value.isEmpty) {
      return "Age required";
    }

    final age = int.tryParse(value);

    if (age == null) {
      return "Age must be a number";
    }

    if (age < 0 || age > 120) {
      return "Invalid age";
    }

    return null;

  }

  static String? validateRequired(String? value, String field) {

    if (value == null || value.trim().isEmpty) {
      return "$field is required";
    }

    return null;

  }

  static bool isStrongPassword(String password) {

    final hasUpper = password.contains(RegExp(r'[A-Z]'));
    final hasLower = password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

    return password.length >= 8 &&
        hasUpper &&
        hasLower &&
        hasNumber &&
        hasSpecial;

  }

  static String? validateHospitalName(String? value) {

    if (value == null || value.isEmpty) {
      return "Hospital name required";
    }

    if (value.length < 3) {
      return "Hospital name too short";
    }

    return null;

  }

  static String? validateReferralReason(String? value) {

    if (value == null || value.isEmpty) {
      return "Referral reason required";
    }

    if (value.length < 5) {
      return "Please provide a valid reason";
    }

    return null;

  }

}