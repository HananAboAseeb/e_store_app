import 'package:equatable/equatable.dart';

import 'chat_order_summary_entity.dart';

class ChatBotFlowEntity extends Equatable {
  final String welcomeMessage;
  final List<String> issueCategories;
  final List<String> orderIssues;
  final List<ChatOrderSummaryEntity> orders;

  const ChatBotFlowEntity({
    required this.welcomeMessage,
    required this.issueCategories,
    required this.orderIssues,
    required this.orders,
  });

  @override
  List<Object?> get props => [
        welcomeMessage,
        issueCategories,
        orderIssues,
        orders,
      ];
}
