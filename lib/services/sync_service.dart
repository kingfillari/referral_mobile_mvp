// lib/services/sync_service.dart
import 'sqlite_service.dart';
import 'api_service.dart';
import '../models/patient_model.dart';
import '../models/referral_model.dart';

/// Handles offline synchronization for patients and referrals
class SyncService {
  final SQLiteService _sqlite = SQLiteService();
  final ApiService _api = ApiService();

  /// Sync all patients to the backend
  Future<void> syncPatients({int? tenantId}) async {
    final patients = await _sqlite.getPatients();
    for (var patient in patients) {
      try {
        final patientMap = patient.toJson();
        if (tenantId != null) {
          patientMap['tenantId'] = tenantId;
        }
        await _api.post('/patients', patientMap);
      } catch (e) {
        print('Sync patient failed: $e');
      }
    }
  }

  /// Sync all referrals to the backend, including tenant ID
  Future<void> syncReferrals({required int tenantId}) async {
    final referrals = await _sqlite.getReferrals();
    for (var referral in referrals) {
      try {
        final referralMap = referral.toJson();
        referralMap['tenantId'] = tenantId;
        await _api.post('/referrals', referralMap);
      } catch (e) {
        print('Sync referral failed: $e');
      }
    }
  }

  /// Full sync (patients + referrals)
  Future<void> syncAll({int? tenantId}) async {
    await syncPatients(tenantId: tenantId);
    if (tenantId != null) {
      await syncReferrals(tenantId: tenantId);
    }
  }
}
