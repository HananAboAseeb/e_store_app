import '../../domain/entities/chat_review_entity.dart';

class ChatReviewModel extends ChatReviewEntity {
  const ChatReviewModel({
    required super.id,
    required super.agentId,
    required super.rating,
    required super.comment,
    required super.submittedAt,
  });

  factory ChatReviewModel.fromMap(Map<String, dynamic> map) {
    return ChatReviewModel(
      id: map['id'] as String? ?? '',
      agentId: map['agentId'] as String? ?? '',
      rating: map['rating'] as int? ?? 5,
      comment: map['comment'] as String? ?? '',
      submittedAt: map['submittedAt'] != null
          ? DateTime.parse(map['submittedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'agentId': agentId,
      'rating': rating,
      'comment': comment,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }
}
