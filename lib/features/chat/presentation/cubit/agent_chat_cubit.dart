import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_order_summary_entity.dart';
import '../../domain/usecases/get_initial_agent_conversation_usecase.dart';
import '../../domain/usecases/get_simulated_agent_reply_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import 'agent_chat_state.dart';

class AgentChatCubit extends Cubit<AgentChatState> {
  final GetInitialAgentConversationUseCase getInitialAgentConversationUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final GetSimulatedAgentReplyUseCase getSimulatedAgentReplyUseCase;

  Timer? _transitionTimer;

  AgentChatCubit({
    required this.getInitialAgentConversationUseCase,
    required this.sendMessageUseCase,
    required this.getSimulatedAgentReplyUseCase,
  }) : super(const AgentChatState());

  @override
  Future<void> close() {
    _transitionTimer?.cancel();
    return super.close();
  }

  Future<void> startAgentHandoff({
    required String issueCategory,
    required String orderIssue,
    required ChatOrderSummaryEntity selectedOrder,
  }) async {
    emit(
      state.copyWith(
        status: AgentChatStatus.loading,
        phase: AgentChatPhase.connecting,
        isTyping: false,
      ),
    );

    final result = await getInitialAgentConversationUseCase(
      InitialConversationParams(
        issueCategory: issueCategory,
        orderIssue: orderIssue,
        selectedOrder: selectedOrder,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AgentChatStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (initialMessages) {
        emit(
          state.copyWith(
            status: AgentChatStatus.loaded,
            phase: AgentChatPhase.connecting,
            messages: initialMessages,
            isTyping: false,
          ),
        );

        // Schedule transition to typing (Screen 72)
        _transitionTimer?.cancel();
        _transitionTimer = Timer(const Duration(milliseconds: 1800), () {
          emit(
            state.copyWith(
              phase: AgentChatPhase.typing,
              isTyping: true,
            ),
          );

          // Schedule first agent message (Screen 73)
          _transitionTimer =
              Timer(const Duration(milliseconds: 1800), () async {
            await _deliverNextAgentReply();
            emit(
              state.copyWith(
                phase: AgentChatPhase.active,
                isTyping: false,
              ),
            );
          });
        });
      },
    );
  }

  Future<void> sendUserMessage(String text) async {
    if (text.trim().isEmpty) return;

    final result = await sendMessageUseCase(text);
    result.fold(
      (_) {},
      (userMsg) async {
        final currentMessages = List.of(state.messages)..add(userMsg);
        emit(state.copyWith(messages: currentMessages, isTyping: true));

        // Simulate agent typing then replying
        _transitionTimer?.cancel();
        _transitionTimer = Timer(const Duration(milliseconds: 1200), () async {
          await _deliverNextAgentReply();
          emit(state.copyWith(isTyping: false));
        });
      },
    );
  }

  Future<void> _deliverNextAgentReply() async {
    final nextIndex = state.agentReplyIndex;
    final result = await getSimulatedAgentReplyUseCase(nextIndex);
    result.fold(
      (_) {},
      (agentMsg) {
        final updated = List.of(state.messages)..add(agentMsg);
        emit(
          state.copyWith(
            messages: updated,
            agentReplyIndex: nextIndex + 1,
          ),
        );

        // If next reply index was 1, also deliver the gift voucher message (reply 2) shortly after
        if (nextIndex == 1) {
          _transitionTimer =
              Timer(const Duration(milliseconds: 1000), () async {
            final voucherReply = await getSimulatedAgentReplyUseCase(2);
            voucherReply.fold((_) {}, (giftMsg) {
              final withGift = List.of(state.messages)..add(giftMsg);
              emit(
                state.copyWith(
                  messages: withGift,
                  agentReplyIndex: 3,
                ),
              );
            });
          });
        }
      },
    );
  }

  void updateScrollToBottomVisibility(bool isVisible) {
    if (state.showScrollToBottom != isVisible) {
      emit(state.copyWith(showScrollToBottom: isVisible));
    }
  }

  void closeChat() {
    emit(state.copyWith(phase: AgentChatPhase.closed));
  }
}
