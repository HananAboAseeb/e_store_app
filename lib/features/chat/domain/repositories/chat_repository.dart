import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat_bot_flow_entity.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chat_order_summary_entity.dart';
import '../entities/chat_review_entity.dart';

abstract class ChatRepository {
  /// Fetches the bot welcome message, issue categories, order issues, and mock orders.
  Future<Either<Failure, ChatBotFlowEntity>> getChatBotFlow();

  /// Fetches the initial agent conversation setup including agent profile and triage history.
  Future<Either<Failure, List<ChatMessageEntity>>> getInitialAgentConversation({
    required String issueCategory,
    required String orderIssue,
    required ChatOrderSummaryEntity selectedOrder,
  });

  /// Sends a customer message in the active chat.
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String text,
  });

  /// Obtains the next scripted or simulated agent reply in sequence.
  Future<Either<Failure, ChatMessageEntity>> getSimulatedAgentReply({
    required int replyIndex,
  });

  /// Submits customer service rating and review feedback.
  Future<Either<Failure, void>> submitReview(ChatReviewEntity review);
}
