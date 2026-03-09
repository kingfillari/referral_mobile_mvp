import 'dart:convert';
import 'package:http/http.dart' as http;
import 'database_service.dart';

class SyncService {

  final dbService = DatabaseService();

  Future syncPatients() async {

    final db = await dbService.database;

    final patients = await db.query(
      "patients",
      where: "synced = ?",
      whereArgs: [0],
    );

    for (var patient in patients) {

      await http.post(
        Uri.parse("https://your-api.com/patients"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(patient),
      );

      await db.update(
        "patients",
        {"synced": 1},
        where: "id = ?",
        whereArgs: [patient["id"]],
      );
    }
  }
}