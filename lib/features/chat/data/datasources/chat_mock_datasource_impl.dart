import '../../../profile/data/models/voucher_model.dart';
import '../../domain/entities/chat_attachment_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../models/chat_attachment_model.dart';
import '../models/chat_bot_flow_model.dart';
import '../models/chat_message_model.dart';
import '../models/chat_order_summary_model.dart';
import '../models/chat_review_model.dart';
import 'chat_mock_datasource.dart';

class ChatMockDataSourceImpl implements ChatMockDataSource {
  @override
  Future<ChatBotFlowModel> getChatBotFlow() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return const ChatBotFlowModel(
      welcomeMessage:
          'Hello, Amanda! Welcome to Customer Care Service. We will be happy to help you. Please, provide us more details about your issue before we can start.',
      issueCategories: [
        'Order Issues',
        'Item Quality',
        'Payment Issues',
        'Technical Assistance',
        'Other',
      ],
      orderIssues: [
        "I didn't receive my order",
        'I want to cancel my order',
        'I want to return my order',
        'Package was damages',
        'Other',
      ],
      orders: [
        ChatOrderSummaryModel(
          id: 'ord_1',
          orderNumber: '#655541',
          deliveryType: 'Standard Delivery',
          itemCount: 4,
          status: 'Shipped',
          thumbnailUrl: 'assets/images/home_flash_1.png',
          isSelected: true,
        ),
        ChatOrderSummaryModel(
          id: 'ord_2',
          orderNumber: '#655540',
          deliveryType: 'Express Delivery',
          itemCount: 2,
          status: 'Delivered',
          thumbnailUrl: 'assets/images/home_flash_2.png',
          isSelected: false,
        ),
        ChatOrderSummaryModel(
          id: 'ord_3',
          orderNumber: '#655539',
          deliveryType: 'Standard Delivery',
          itemCount: 1,
          status: 'Delivered',
          thumbnailUrl: 'assets/images/home_flash_3.png',
          isSelected: false,
        ),
      ],
    );
  }

  @override
  Future<List<ChatMessageModel>> getInitialAgentConversation({
    required String issueCategory,
    required String orderIssue,
    required ChatOrderSummaryModel selectedOrder,
  }) async {
    await Future.delayed(const Duration(milliseconds: 50));

    return [
      const ChatMessageModel(
        id: 'msg_0',
        sender: ChatMessageSender.bot,
        text:
            'Hello, Amanda! Welcome to Customer Care Service. We will be happy to help you. Please, provide us more details about your issue before we can start.',
        timestamp: '12:44 PM',
      ),
      ChatMessageModel(
        id: 'msg_1',
        sender: ChatMessageSender.user,
        text: issueCategory.isNotEmpty ? issueCategory : 'Order Issues',
        timestamp: '12:44 PM',
      ),
      ChatMessageModel(
        id: 'msg_2',
        sender: ChatMessageSender.user,
        text: orderIssue.isNotEmpty ? orderIssue : "I didn't receive my order",
        timestamp: '12:45 PM',
      ),
      ChatMessageModel(
        id: 'msg_3',
        sender: ChatMessageSender.user,
        text: 'Order ${selectedOrder.orderNumber}',
        timestamp: '12:45 PM',
        attachment: ChatAttachmentModel(
          type: ChatAttachmentType.order,
          order: selectedOrder.copyWith(isSelected: true),
        ),
      ),
    ];
  }

  @override
  Future<ChatMessageModel> sendMessage({required String text}) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return ChatMessageModel(
      id: 'msg_user_${DateTime.now().millisecondsSinceEpoch}',
      sender: ChatMessageSender.user,
      text: text,
      timestamp: '12:46 PM',
    );
  }

  @override
  Future<ChatMessageModel> getSimulatedAgentReply({
    required int replyIndex,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    switch (replyIndex) {
      case 0:
        return const ChatMessageModel(
          id: 'agent_msg_1',
          sender: ChatMessageSender.agent,
          text:
              "Hello, Amanda! I'm Maggy, your personal assistant from Customer Care Service. Let me go through your order and check its current status. Wait a moment please.",
          timestamp: '12:45 PM',
        );
      case 1:
        return const ChatMessageModel(
          id: 'agent_msg_2',
          sender: ChatMessageSender.agent,
          text:
              'Thank you for waiting Amanda! I just checked your order status and seems like there was a problem on our end. We are really sorry about that. You will receive your parcel within 2 days.',
          timestamp: '12:46 PM',
        );
      case 2:
        return const ChatMessageModel(
          id: 'agent_msg_3',
          sender: ChatMessageSender.agent,
          text:
              'We would like to give you a small gift. 15% off for your next purchase.',
          timestamp: '12:46 PM',
          attachment: ChatAttachmentModel(
            type: ChatAttachmentType.voucher,
            voucher: VoucherModel(
              id: 'v_chat_1',
              title: '15% off your next purchase',
              subtitle: '',
              validUntil: '5.16.20',
              isExpiring: false,
              daysLeft: 14,
              iconType: 'badge',
            ),
          ),
        );
      case 3:
        return const ChatMessageModel(
          id: 'agent_msg_4',
          sender: ChatMessageSender.agent,
          text: 'Is there anything else I can help you with?',
          timestamp: '12:47 PM',
        );
      case 4:
      default:
        return const ChatMessageModel(
          id: 'agent_msg_5',
          sender: ChatMessageSender.agent,
          text: 'Great! Have a nice day! Was happy to help you.',
          timestamp: '12:48 PM',
        );
    }
  }

  @override
  Future<void> submitReview(ChatReviewModel review) async {
    await Future.delayed(const Duration(milliseconds: 150));
  }
}
