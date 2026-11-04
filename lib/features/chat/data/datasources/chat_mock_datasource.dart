import '../models/chat_bot_flow_model.dart';
import '../models/chat_message_model.dart';
import '../models/chat_order_summary_model.dart';
import '../models/chat_review_model.dart';

abstract class ChatMockDataSource {
  Future<ChatBotFlowModel> getChatBotFlow();

  Future<List<ChatMessageModel>> getInitialAgentConversation({
    required String issueCategory,
    required String orderIssue,
    required ChatOrderSummaryModel selectedOrder,
  });

  Future<ChatMessageModel> sendMessage({required String text});

  Future<ChatMessageModel> getSimulatedAgentReply({required int replyIndex});

  Future<void> submitReview(ChatReviewModel review);
}
