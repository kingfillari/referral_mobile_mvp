import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'storage_service.dart';
import '../config/api_config.dart';
import '../models/user_model.dart';

/// Handles user authentication, JWT tokens, and role-based routing
class AuthService {
  final StorageService _storage = StorageService();

  /// Login user with email & password
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // ✅ Fixed: read 'data' and 'access_token'
        final Map<String, dynamic> responseData = jsonDecode(response.body)['data'];
        final user = UserModel.fromJson(responseData['user']);
        final token = responseData['access_token'];

        await _storage.saveToken(token);
        await _storage.saveUser(user);

        return user;
      } else {
        debugPrint('Login failed: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Login exception: $e');
      return null;
    }
  }

  /// Register user
  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': name,  // NestJS expects "fullName"
          'email': email,
          'password': password,
          'role': role.toUpperCase(), // ADMIN, DOCTOR, NURSE, HOSPITAL
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // ✅ Fixed: read 'data' and 'access_token'
        final Map<String, dynamic> responseData = jsonDecode(response.body)['data'];

        if (responseData['user'] == null || responseData['access_token'] == null) {
          debugPrint('Register failed: Missing user or token in response');
          return null;
        }

        final user = UserModel.fromJson(responseData['user']);
        final token = responseData['access_token'];

        await _storage.saveToken(token);
        await _storage.saveUser(user);

        return user;
      } else {
        debugPrint('Register failed: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Register exception: $e');
      return null;
    }
  }

  /// Logout user
  Future<void> logout() async {
    await _storage.clearAll();
  }

  /// Get currently saved user
  Future<UserModel?> getCurrentUser() async {
    return await _storage.getUser();
  }

  /// Get JWT token
  Future<String?> getToken() async => await _storage.getToken();

  /// Determine dashboard route based on role
  String getDashboardRoute(UserModel user) {
    switch (user.role.toUpperCase()) {
      case 'NURSE':
        return '/nurse-dashboard';
      case 'DOCTOR':
        return '/doctor-dashboard';
      case 'HOSPITAL':
        return '/hospital-dashboard';
      case 'ADMIN':
        return '/admin-dashboard';
      default:
        return '/login';
    }
  }
}