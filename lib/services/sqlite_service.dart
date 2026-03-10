import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/patient_model.dart';
import '../models/referral_model.dart';

/// SQLite service for offline storage
class SQLiteService {
  static final SQLiteService _instance = SQLiteService._internal();
  factory SQLiteService() => _instance;
  SQLiteService._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'rms_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE patients(
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER,
        gender TEXT,
        phone TEXT,
        address TEXT,
        mrn TEXT,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE referrals(
        id INTEGER PRIMARY KEY,
        patient_id INTEGER,
        referring_facility TEXT,
        receiving_facility TEXT,
        priority TEXT,
        clinical_summary TEXT,
        status TEXT,
        created_at TEXT
      )
    ''');
  }

  // Patient CRUD
  Future<int> insertPatient(Patient patient) async {
    final db = await database;
    return await db.insert('patients', patient.toMap());
  }

  Future<List<Patient>> getPatients() async {
    final db = await database;
    final maps = await db.query('patients');
    return List.generate(maps.length, (i) => Patient.fromMap(maps[i]));
  }

  // Referral CRUD
  Future<int> insertReferral(Referral referral) async {
    final db = await database;
    return await db.insert('referrals', referral.toMap());
  }

  Future<List<Referral>> getReferrals() async {
    final db = await database;
    final maps = await db.query('referrals');
    return List.generate(maps.length, (i) => Referral.fromMap(maps[i]));
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('patients');
    await db.delete('referrals');
  }
}