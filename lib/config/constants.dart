/// Application-wide constants
/// Includes statuses, priorities, validation rules, default values
class AppConstants {
  /// Referral priorities
  static const List<String> referralPriorities = [
    'Routine',
    'Urgent',
    'Emergency',
  ];

  /// Referral statuses
  static const List<String> referralStatuses = [
    'Pending',
    'Accepted',
    'Rejected',
    'Completed',
  ];

  /// Facility types
  static const List<String> facilityTypes = [
    'Health Center',
    'Hospital',
    'Clinic',
    'Specialty Hospital',
  ];

  /// Default avatar image path
  static const String defaultAvatar = 'assets/images/default_avatar.png';

  /// Local SQLite table names
  static const String tableUsers = 'users';
  static const String tablePatients = 'patients';
  static const String tableReferrals = 'referrals';
  static const String tableHospitals = 'hospitals';
  static const String tableReferralUpdates = 'referral_updates';
  static const String tableAppointments = 'appointments';
  static const String tableComments = 'comments';

  /// Form validation regex patterns
  static const String emailPattern =
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
  static const String phonePattern = r'^\+?\d{7,15}$';

  /// Local storage keys
  static const String keyToken = 'JWT_TOKEN';
  static const String keyUser = 'CURRENT_USER';

  /// Miscellaneous constants
  static const int defaultPageSize = 20;
  static const int syncRetryLimit = 3;
  static const int notificationRefreshInterval = 60; // in seconds

  /// Default empty string
  static const String empty = '';
}