import '../../domain/entities/chat_bot_flow_entity.dart';
import 'chat_order_summary_model.dart';

class ChatBotFlowModel extends ChatBotFlowEntity {
  const ChatBotFlowModel({
    required super.welcomeMessage,
    required super.issueCategories,
    required super.orderIssues,
    required super.orders,
  });

  factory ChatBotFlowModel.fromMap(Map<String, dynamic> map) {
    return ChatBotFlowModel(
      welcomeMessage: map['welcomeMessage'] as String? ?? '',
      issueCategories: (map['issueCategories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      orderIssues: (map['orderIssues'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      orders: (map['orders'] as List<dynamic>?)
              ?.map((e) =>
                  ChatOrderSummaryModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'welcomeMessage': welcomeMessage,
      'issueCategories': issueCategories,
      'orderIssues': orderIssues,
      'orders': orders
          .map((e) => e is ChatOrderSummaryModel
              ? e.toMap()
              : ChatOrderSummaryModel.fromEntity(e).toMap())
          .toList(),
    };
  }
}
