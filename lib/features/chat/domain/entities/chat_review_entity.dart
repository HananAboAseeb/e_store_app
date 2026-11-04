import 'package:equatable/equatable.dart';

class ChatReviewEntity extends Equatable {
  final String id;
  final String agentId;
  final int rating;
  final String comment;
  final DateTime submittedAt;

  const ChatReviewEntity({
    required this.id,
    required this.agentId,
    required this.rating,
    required this.comment,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [id, agentId, rating, comment, submittedAt];
}
