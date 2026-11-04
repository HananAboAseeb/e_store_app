import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_order_summary_entity.dart';

enum ChatBotStep { issue, orderIssue, selectOrder, completed }

enum ChatBotStatus { initial, loading, loaded, error }

class ChatBotState extends Equatable {
  final ChatBotStatus status;
  final ChatBotStep step;
  final String welcomeMessage;
  final List<String> issueCategories;
  final List<String> orderIssues;
  final List<ChatOrderSummaryEntity> orders;
  final String selectedIssue;
  final String selectedOrderIssue;
  final ChatOrderSummaryEntity? selectedOrder;
  final String? errorMessage;

  const ChatBotState({
    this.status = ChatBotStatus.initial,
    this.step = ChatBotStep.issue,
    this.welcomeMessage = '',
    this.issueCategories = const [],
    this.orderIssues = const [],
    this.orders = const [],
    this.selectedIssue = 'Order Issues',
    this.selectedOrderIssue = "I didn't receive my order",
    this.selectedOrder,
    this.errorMessage,
  });

  ChatBotState copyWith({
    ChatBotStatus? status,
    ChatBotStep? step,
    String? welcomeMessage,
    List<String>? issueCategories,
    List<String>? orderIssues,
    List<ChatOrderSummaryEntity>? orders,
    String? selectedIssue,
    String? selectedOrderIssue,
    ChatOrderSummaryEntity? selectedOrder,
    String? errorMessage,
  }) {
    return ChatBotState(
      status: status ?? this.status,
      step: step ?? this.step,
      welcomeMessage: welcomeMessage ?? this.welcomeMessage,
      issueCategories: issueCategories ?? this.issueCategories,
      orderIssues: orderIssues ?? this.orderIssues,
      orders: orders ?? this.orders,
      selectedIssue: selectedIssue ?? this.selectedIssue,
      selectedOrderIssue: selectedOrderIssue ?? this.selectedOrderIssue,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        step,
        welcomeMessage,
        issueCategories,
        orderIssues,
        orders,
        selectedIssue,
        selectedOrderIssue,
        selectedOrder,
        errorMessage,
      ];
}
