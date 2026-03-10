/// Environment configuration: dev/staging/prod
/// This is useful for switching API endpoints or logging behavior
class EnvConfig {
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'DEV', // Default to DEV
  );

  static String get baseUrl {
    switch (environment.toUpperCase()) {
      case 'PROD':
        return "https://rms-backend.example.com/api";
      case 'STAGING':
        return "https://staging-rms-backend.example.com/api";
      default:
        return "https://dev-rms-backend.example.com/api";
    }
  }

  static bool get isProduction => environment.toUpperCase() == 'PROD';
  static bool get isStaging => environment.toUpperCase() == 'STAGING';
  static bool get isDev => environment.toUpperCase() == 'DEV';

  /// Example debug print
  static void log(String message) {
    if (!isProduction) {
      print('[${environment.toUpperCase()}] $message');
    }
  }
}