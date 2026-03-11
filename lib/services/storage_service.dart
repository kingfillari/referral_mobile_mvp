import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'dart:convert';

/// Secure storage for JWT token and user info
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// Static helper to initialize
  static Future<void> init() async {
    // Nothing special needed for flutter_secure_storage, just placeholder
    _instance;
  }

  /// Static getter for current user
  static Future<UserModel?> getUser() async {
    return await _instance._getUser();
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'jwt_token');
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'jwt_token');
  }

  Future<void> saveUser(UserModel user) async {
    await _secureStorage.write(key: 'current_user', value: jsonEncode(user.toJson()));
  }

  Future<UserModel?> _getUser() async {
    final data = await _secureStorage.read(key: 'current_user');
    if (data != null) return UserModel.fromJson(jsonDecode(data));
    return null;
  }

  Future<void> clearUser() async {
    await _secureStorage.delete(key: 'current_user');
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}