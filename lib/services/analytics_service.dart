import 'sqlite_service.dart';
import '../models/referral_model.dart';

/// Analytics service for tracking usage stats
class AnalyticsService {
  final SQLiteService _sqlite = SQLiteService();

  /// Get total referrals per hospital
  Future<Map<String, int>> getReferralCountByHospital() async {
    final referrals = await _sqlite.getReferrals();
    final Map<String, int> stats = {};

    for (var ref in referrals) {
      stats[ref.receivingFacility] = (stats[ref.receivingFacility] ?? 0) + 1;
    }

    return stats;
  }

  /// Get most active nurse
  Future<String?> getTopNurse() async {
    final referrals = await _sqlite.getReferrals();
    if (referrals.isEmpty) return null;

    final Map<String, int> nurseCount = {};
    for (var ref in referrals) {
      nurseCount[ref.referringFacility] =
          (nurseCount[ref.referringFacility] ?? 0) + 1;
    }

    // Get max
    String topNurse = nurseCount.keys.first;
    int maxCount = nurseCount[topNurse]!;
    nurseCount.forEach((k, v) {
      if (v > maxCount) {
        topNurse = k;
        maxCount = v;
      }
    });

    return topNurse;
  }

  /// Get referral stats by priority
  Future<Map<String, int>> getReferralStats() async {
    final referrals = await _sqlite.getReferrals();
    final Map<String, int> stats = {'Emergency': 0, 'Urgent': 0, 'Routine': 0};
    for (var ref in referrals) {
      if (stats.containsKey(ref.priority)) {
        stats[ref.priority] = stats[ref.priority]! + 1;
      }
    }
    return stats;
  }
}