/// Role definitions used in the RMS system
/// Roles are used for role-based dashboards and permissions
class UserRoles {
  static const String nurse = "NURSE";
  static const String doctor = "DOCTOR";
  static const String hospitalStaff = "HOSPITAL";
  static const String admin = "ADMIN";

  /// List of all roles
  static const List<String> allRoles = [
    nurse,
    doctor,
    hospitalStaff,
    admin,
  ];

  /// Check if a role has full admin permissions
  static bool isAdmin(String role) => role.toUpperCase() == admin;

  /// Check if a role can create referrals
  static bool canCreateReferral(String role) =>
      role.toUpperCase() == nurse || role.toUpperCase() == doctor;

  /// Check if a role can manage facilities
  static bool canManageFacilities(String role) => isAdmin(role);

  /// Check if a role can review referrals
  static bool canReviewReferral(String role) =>
      role.toUpperCase() == doctor || role.toUpperCase() == hospitalStaff;

  /// Get human-friendly role label
  static String roleLabel(String role) {
    switch (role.toUpperCase()) {
      case nurse:
        return 'Nurse';
      case doctor:
        return 'Doctor';
      case hospitalStaff:
        return 'Hospital Staff';
      case admin:
        return 'Administrator';
      default:
        return 'Unknown';
    }
  }
}