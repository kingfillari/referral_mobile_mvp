/// EnvService: Manage different environments (dev, staging, prod)
class EnvService {
  static const String devBaseUrl = 'https://dev.api.rmsapp.com';
  static const String stagingBaseUrl = 'https://staging.api.rmsapp.com';
  static const String prodBaseUrl = 'https://api.rmsapp.com';

  static String currentEnv = 'dev';

  static String get baseUrl {
    switch (currentEnv) {
      case 'staging':
        return stagingBaseUrl;
      case 'prod':
        return prodBaseUrl;
      case 'dev':
      default:
        return devBaseUrl;
    }
  }

  static void setEnvironment(String env) {
    if (['dev', 'staging', 'prod'].contains(env)) {
      currentEnv = env;
    }
  }
}