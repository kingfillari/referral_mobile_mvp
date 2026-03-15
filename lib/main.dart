import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'config/roles.dart';
import 'services/storage_service.dart';
import 'services/sync_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/dashboards/nurse_dashboard.dart';
import 'screens/dashboards/doctor_dashboard.dart';
import 'screens/dashboards/hospital_dashboard.dart';
import 'screens/dashboards/admin_dashboard.dart';
import 'models/user_model.dart';

/// Entry point for the RMS Mobile App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(RMSApp());
}

class RMSApp extends StatelessWidget {
  RMSApp({Key? key}) : super(key: key);

  final SyncService _syncService = SyncService();

  /// Determine initial screen based on logged-in user
  Future<Widget> _getInitialScreen() async {
    final UserModel? user = await StorageService().getUser();

    if (user == null) {
      return const LoginScreen();
    } else {
      // Automatic sync after app startup
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final tenantId = user.tenantId ?? 1; // default if null
await syncService.syncAll(tenantId: tenantId);      });

      switch (user.role.toUpperCase()) {
        case UserRoles.nurse:
          return NurseDashboard(user: user);
        case UserRoles.doctor:
          return DoctorDashboard(user: user);
        case UserRoles.hospitalStaff:
          return HospitalDashboard(user: user);
        case UserRoles.admin:
          return AdminDashboard(user: user);
        default:
          return const LoginScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: Scaffold(
              body: Center(
                child: Text(
                  'Initialization failed: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        } else {
          // Snapshot already contains the correct initial screen widget
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Referral Management System',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: snapshot.data,
            routes: {
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
            },
          );
        }
      },
    );
  }
}