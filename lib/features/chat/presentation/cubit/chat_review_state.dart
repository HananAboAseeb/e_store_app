import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_agent_entity.dart';

enum ChatReviewStatus { initial, writing, submitting, submitted, error }

class ChatReviewState extends Equatable {
  final ChatReviewStatus status;
  final ChatAgentEntity agent;
  final int rating;
  final String comment;
  final String? errorMessage;

  const ChatReviewState({
    this.status = ChatReviewStatus.initial,
    this.agent = const ChatAgentEntity(
      id: 'agent_maggie',
      name: 'Maggy Lee',
      role: 'Customer Care Service',
      avatarUrl: 'assets/images/profile_picture.png',
    ),
    this.rating = 0,
    this.comment = '',
    this.errorMessage,
  });

  ChatReviewState copyWith({
    ChatReviewStatus? status,
    ChatAgentEntity? agent,
    int? rating,
    String? comment,
    String? errorMessage,
  }) {
    return ChatReviewState(
      status: status ?? this.status,
      agent: agent ?? this.agent,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, agent, rating, comment, errorMessage];
}
