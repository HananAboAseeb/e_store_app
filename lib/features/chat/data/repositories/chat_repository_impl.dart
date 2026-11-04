import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/chat_bot_flow_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_order_summary_entity.dart';
import '../../domain/entities/chat_review_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_mock_datasource.dart';
import '../models/chat_order_summary_model.dart';
import '../models/chat_review_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatMockDataSource mockDataSource;

  ChatRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, ChatBotFlowEntity>> getChatBotFlow() async {
    return await safeCall(() => mockDataSource.getChatBotFlow());
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getInitialAgentConversation({
    required String issueCategory,
    required String orderIssue,
    required ChatOrderSummaryEntity selectedOrder,
  }) async {
    final orderModel = ChatOrderSummaryModel.fromEntity(selectedOrder);
    return await safeCall(
      () => mockDataSource.getInitialAgentConversation(
        issueCategory: issueCategory,
        orderIssue: orderIssue,
        selectedOrder: orderModel,
      ),
    );
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String text,
  }) async {
    return await safeCall(() => mockDataSource.sendMessage(text: text));
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> getSimulatedAgentReply({
    required int replyIndex,
  }) async {
    return await safeCall(
      () => mockDataSource.getSimulatedAgentReply(replyIndex: replyIndex),
    );
  }

  @override
  Future<Either<Failure, void>> submitReview(ChatReviewEntity review) async {
    final reviewModel = ChatReviewModel(
      id: review.id,
      agentId: review.agentId,
      rating: review.rating,
      comment: review.comment,
      submittedAt: review.submittedAt,
    );
    return await safeCall(() => mockDataSource.submitReview(reviewModel));
  }
}
