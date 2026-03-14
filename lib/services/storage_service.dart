import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'dart:convert';

/// Secure storage for JWT token and user info
class StorageService {
  // Singleton instance
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// Initialize storage (optional, placeholder)
  static Future<void> init() async {
    // No special initialization needed for flutter_secure_storage
  }

  /// Save JWT token
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'jwt_token', value: token);
  }

  /// Get JWT token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'jwt_token');
  }

  /// Delete JWT token
  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'jwt_token');
  }

  /// Save user info
  Future<void> saveUser(UserModel user) async {
    await _secureStorage.write(
      key: 'current_user',
      value: jsonEncode(user.toJson()),
    );
  }

  /// Get current user (instance method)
  Future<UserModel?> getUser() async {   // ✅ fixed
    final data = await _secureStorage.read(key: 'current_user');
    if (data != null) return UserModel.fromJson(jsonDecode(data));
    return null;
  }

  /// Delete user info
  Future<void> clearUser() async {
    await _secureStorage.delete(key: 'current_user');
  }

  /// Clear all storage
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}