import 'sqlite_service.dart';
import '../models/comment_model.dart';

/// Comment / feedback system
class CommentService {
  final SQLiteService _sqlite = SQLiteService();

  /// Add comment
  Future<void> addComment(CommentModel comment) async {
    final db = await _sqlite.database;
    await db.insert('comments', comment.toMap());
  }

  /// Get all comments
  Future<List<CommentModel>> getComments() async {
    final db = await _sqlite.database;
    final maps = await db.query('comments');
    return List.generate(maps.length, (i) => CommentModel.fromMap(maps[i]));
  }

  /// Delete comment
  Future<void> deleteComment(int id) async {
    final db = await _sqlite.database;
    await db.delete('comments', where: 'id = ?', whereArgs: [id]);
  }

  /// Update comment
  Future<void> updateComment(CommentModel comment) async {
    final db = await _sqlite.database;
    await db.update('comments', comment.toMap(),
        where: 'id = ?', whereArgs: [comment.id]);
  }
}