import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {

  static Database? _database;

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {

    String path = join(await getDatabasesPath(), "referral.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        await db.execute('''
        CREATE TABLE patients(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        gender TEXT,
        phone TEXT,
        address TEXT,
        notes TEXT,
        synced INTEGER
        )
        ''');

        await db.execute('''
        CREATE TABLE referrals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER,
        hospital TEXT,
        priority TEXT,
        clinical_notes TEXT,
        status TEXT,
        synced INTEGER
        )
        ''');
      },
    );
  }
}