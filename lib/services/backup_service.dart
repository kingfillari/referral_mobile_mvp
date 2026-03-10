backup_service.dart


import 'dart:io';
import 'file_service.dart';
import 'sqlite_service.dart';

/// BackupService: Backup SQLite DB periodically
class BackupService {
  final SQLiteService _sqliteService = SQLiteService();
  final FileService _fileService = FileService();

  /// Backup local SQLite DB to server
  Future<bool> backupDatabase(String serverEndpoint) async {
    final dbFile = await _sqliteService.getDatabaseFile();
    if (dbFile == null) return false;

    final success = await _fileService.uploadFile(serverEndpoint, dbFile);
    return success;
  }
}