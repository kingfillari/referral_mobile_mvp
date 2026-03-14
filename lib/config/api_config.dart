/// API configuration for RMS mobile app
/// Contains all backend endpoints for REST API communication
class ApiConfig {
  /// Base URL for backend API (update according to your environment)
static const String baseUrl = "http://10.181.1.45:3000";

  /// Authentication endpoints
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String refreshToken = "$baseUrl/auth/refresh";

  /// Patient endpoints
  static const String patients = "$baseUrl/patients";
  static const String patientDetails = "$baseUrl/patients/{id}";

  /// Referral endpoints
  static const String referrals = "$baseUrl/referrals";
  static const String referralDetails = "$baseUrl/referrals/{id}";
  static const String referralUpdates = "$baseUrl/referrals/{id}/updates";

  /// Hospital endpoints
  static const String hospitals = "$baseUrl/hospitals";
  static const String hospitalDetails = "$baseUrl/hospitals/{id}";

  /// Appointment endpoints
  static const String appointments = "$baseUrl/appointments";
  static const String appointmentDetails = "$baseUrl/appointments/{id}";

  /// Comment & feedback endpoints
  static const String comments = "$baseUrl/comments";
  static const String feedback = "$baseUrl/feedback";

  /// Notification endpoints
  static const String notifications = "$baseUrl/notifications";

  /// Utility: Replace path parameters dynamically
  static String resolvePath(String path, Map<String, dynamic> params) {
    String resolved = path;
    params.forEach((key, value) {
      resolved = resolved.replaceAll('{$key}', value.toString());
    });
    return resolved;
  }

  /// Example usage of resolvePath
  ///
  /// String url = ApiConfig.resolvePath(ApiConfig.referralDetails, {'id': 123});
  /// print(url); // Output: https://rms-backend.example.com/api/referrals/123
}