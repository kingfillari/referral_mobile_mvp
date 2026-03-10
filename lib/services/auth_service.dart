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
        Uri.parse(ApiConfig.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data['user']);
        final token = data['token'];

        // Store token securely
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

  /// Logout user and clear storage
  Future<void> logout() async {
    await _storage.clearToken();
    await _storage.clearUser();
  }

  /// Get current user from storage
  Future<UserModel?> getCurrentUser() async {
    return await _storage.getUser();
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _storage.getToken();
    return token != null && token.isNotEmpty;
  }

  /// Get JWT token
  Future<String?> getToken() async {
    return await _storage.getToken();
  }

  /// Route user based on role
  String getDashboardRoute(UserModel user) {
    switch (user.role) {
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