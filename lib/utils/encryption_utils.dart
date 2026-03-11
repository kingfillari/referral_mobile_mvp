import 'dart:convert';
import 'package:crypto/crypto.dart';

class EncryptionUtils {

  static String hashPassword(String password) {

    final bytes = utf8.encode(password);

    final digest = sha256.convert(bytes);

    return digest.toString();

  }

  static String hashData(String data) {

    final bytes = utf8.encode(data);

    final digest = sha256.convert(bytes);

    return digest.toString();

  }

  static bool verifyHash(String input, String storedHash) {

    final inputHash = hashData(input);

    return inputHash == storedHash;

  }

  static String encodeBase64(String value) {

    return base64Encode(utf8.encode(value));

  }

  static String decodeBase64(String value) {

    return utf8.decode(base64Decode(value));

  }

  static String secureToken(String userId) {

    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final raw = "$userId-$timestamp";

    return hashData(raw);

  }

}