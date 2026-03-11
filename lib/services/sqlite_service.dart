import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/patient_model.dart';
import '../models/referral_model.dart';
import '../models/user_model.dart';
import '../models/hospital_model.dart';

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

    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        name TEXT,
        role TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE hospitals(
        id INTEGER PRIMARY KEY,
        name TEXT,
        location TEXT
      )
    ''');
  }

  // Patient CRUD
  Future<int> insertPatient(PatientModel patient) async {
    final db = await database;
    return await db.insert('patients', patient.toMap());
  }

  Future<List<PatientModel>> getPatients() async {
    final db = await database;
    final maps = await db.query('patients');
    return List.generate(maps.length, (i) => PatientModel.fromMap(maps[i]));
  }

  // Referral CRUD
  Future<int> insertReferral(ReferralModel referral) async {
    final db = await database;
    return await db.insert('referrals', referral.toMap());
  }

  Future<List<ReferralModel>> getReferrals() async {
    final db = await database;
    final maps = await db.query('referrals');
    return List.generate(maps.length, (i) => ReferralModel.fromMap(maps[i]));
  }

  Future<int> updateReferralStatus(int id, String status) async {
    final db = await database;
    return await db.update(
      'referrals',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('patients');
    await db.delete('referrals');
    await db.delete('users');
    await db.delete('hospitals');
  }

  /// Added methods to fix AdminDashboard errors
  Future<List<UserModel>> getUsers() async {
    final db = await database;
    final maps = await db.query('users');
    return maps.map((m) => UserModel.fromMap(m)).toList();
  }

  Future<List<HospitalModel>> getHospitals() async {
    final db = await database;
    final maps = await db.query('hospitals');
    return maps.map((m) => HospitalModel.fromMap(m)).toList();
  }
}