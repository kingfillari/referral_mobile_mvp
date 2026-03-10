import 'dart:convert';

/// System comment, feedback, or user notes
class CommentModel {
  final int id;
  final int userId;      // Who made the comment
  final int? referralId; // Related referral (optional)
  final String comment;
  final String type;     // Info / Warning / Error / Feedback
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.userId,
    this.referralId,
    required this.comment,
    required this.type,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      referralId: json['referral_id'],
      comment: json['comment'] ?? '',
      type: json['type'] ?? 'Info',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'referral_id': referralId,
      'comment': comment,
      'type': type,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'referral_id': referralId,
      'comment': comment,
      'type': type,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? 0,
      userId: map['user_id'] ?? 0,
      referralId: map['referral_id'],
      comment: map['comment'] ?? '',
      type: map['type'] ?? 'Info',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// Short display label
  String displayLabel() => '${type.toUpperCase()}: ${comment.length > 50 ? comment.substring(0, 50) + '...' : comment}';

  /// Copy with new values
  CommentModel copyWith({
    int? id,
    int? userId,
    int? referralId,
    String? comment,
    String? type,
    DateTime? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      referralId: referralId ?? this.referralId,
      comment: comment ?? this.comment,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Comment{id: $id, userId: $userId, referralId: $referralId, type: $type}';
  }
}