import '../models/user_model.dart';
import 'auth_service.dart';

/// Role-based access management
class RoleService {
  final AuthService _authService = AuthService();

  /// Check if user has a specific role
  Future<bool> hasRole(String requiredRole) async {
    final user = await _authService.getCurrentUser();
    if (user == null) return false;
    return user.role == requiredRole;
  }

  /// Check if user can access a feature
  Future<bool> canAccessFeature(String feature) async {
    final user = await _authService.getCurrentUser();
    if (user == null) return false;

    // Example feature access map
    final featureAccess = {
      'create_referral': ['NURSE', 'DOCTOR'],
      'view_referrals': ['NURSE', 'DOCTOR', 'HOSPITAL', 'ADMIN'],
      'manage_users': ['ADMIN'],
      'schedule_appointment': ['HOSPITAL', 'DOCTOR'],
    };

    if (!featureAccess.containsKey(feature)) return false;
    return featureAccess[feature]!.contains(user.role);
  }

  /// Get all roles available
  List<String> getAllRoles() {
    return ['NURSE', 'DOCTOR', 'HOSPITAL', 'ADMIN'];
  }

  /// Route user to dashboard based on role
  Future<String> getDashboardRoute() async {
    final user = await _authService.getCurrentUser();
    if (user == null) return '/login';

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

  /// Determine if user can edit a referral
  Future<bool> canEditReferral(int referralPriority) async {
    final user = await _authService.getCurrentUser();
    if (user == null) return false;

    // Example logic
    if (user.role == 'ADMIN') return true;
    if (user.role == 'DOCTOR' && referralPriority < 3) return true; // e.g., 1 = Emergency
    if (user.role == 'NURSE' && referralPriority == 3) return true; // Routine
    return false;
  }
}