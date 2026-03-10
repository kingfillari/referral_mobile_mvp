import 'sqlite_service.dart';
import 'api_service.dart';
import '../models/patient_model.dart';
import '../models/referral_model.dart';

/// Handles offline synchronization
class SyncService {
  final SQLiteService _sqlite = SQLiteService();
  final ApiService _api = ApiService();

  /// Sync patients
  Future<void> syncPatients() async {
    final patients = await _sqlite.getPatients();
    for (var patient in patients) {
      try {
        await _api.post('/patients', patient.toJson());
      } catch (e) {
        print('Sync patient failed: $e');
      }
    }
  }

  /// Sync referrals
  Future<void> syncReferrals() async {
    final referrals = await _sqlite.getReferrals();
    for (var referral in referrals) {
      try {
        await _api.post('/referrals', referral.toJson());
      } catch (e) {
        print('Sync referral failed: $e');
      }
    }
  }

  /// Full sync
  Future<void> syncAll() async {
    await syncPatients();
    await syncReferrals();
  }
}