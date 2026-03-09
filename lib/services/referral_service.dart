import '../models/referral_model.dart';
import 'database_service.dart';

class ReferralService {

  final dbService = DatabaseService();

  Future createReferral(Referral referral) async {

    final db = await dbService.database;

    await db.insert("referrals", referral.toMap());
  }

}