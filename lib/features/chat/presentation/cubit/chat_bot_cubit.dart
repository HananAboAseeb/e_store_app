import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_order_summary_entity.dart';
import '../../domain/usecases/get_chat_bot_flow_usecase.dart';
import 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final GetChatBotFlowUseCase getChatBotFlowUseCase;

  ChatBotCubit({required this.getChatBotFlowUseCase})
      : super(const ChatBotState());

  Future<void> loadBotFlow() async {
    emit(state.copyWith(status: ChatBotStatus.loading));
    final result = await getChatBotFlowUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ChatBotStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (flow) {
        final initialOrder = flow.orders.isNotEmpty ? flow.orders.first : null;
        emit(
          state.copyWith(
            status: ChatBotStatus.loaded,
            welcomeMessage: flow.welcomeMessage,
            issueCategories: flow.issueCategories,
            orderIssues: flow.orderIssues,
            orders: flow.orders,
            selectedIssue: flow.issueCategories.isNotEmpty
                ? flow.issueCategories.first
                : 'Order Issues',
            selectedOrderIssue: flow.orderIssues.isNotEmpty
                ? flow.orderIssues.first
                : "I didn't receive my order",
            selectedOrder: initialOrder,
          ),
        );
      },
    );
  }

  void selectIssue(String issue) {
    emit(state.copyWith(selectedIssue: issue));
  }

  void selectOrderIssue(String orderIssue) {
    emit(state.copyWith(selectedOrderIssue: orderIssue));
  }

  void selectOrder(ChatOrderSummaryEntity order) {
    final updatedOrders = state.orders.map((o) {
      return o.copyWith(isSelected: o.id == order.id);
    }).toList();

    emit(
      state.copyWith(
        orders: updatedOrders,
        selectedOrder: order.copyWith(isSelected: true),
      ),
    );
  }

  void next() {
    switch (state.step) {
      case ChatBotStep.issue:
        emit(state.copyWith(step: ChatBotStep.orderIssue));
        break;
      case ChatBotStep.orderIssue:
        emit(state.copyWith(step: ChatBotStep.selectOrder));
        break;
      case ChatBotStep.selectOrder:
        emit(state.copyWith(step: ChatBotStep.completed));
        break;
      case ChatBotStep.completed:
        break;
    }
  }

  void back() {
    switch (state.step) {
      case ChatBotStep.issue:
        break;
      case ChatBotStep.orderIssue:
        emit(state.copyWith(step: ChatBotStep.issue));
        break;
      case ChatBotStep.selectOrder:
        emit(state.copyWith(step: ChatBotStep.orderIssue));
        break;
      case ChatBotStep.completed:
        emit(state.copyWith(step: ChatBotStep.selectOrder));
        break;
    }
  }
}
