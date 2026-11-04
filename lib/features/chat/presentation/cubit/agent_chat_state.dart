import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_agent_entity.dart';
import '../../domain/entities/chat_message_entity.dart';

enum AgentChatPhase { connecting, typing, active, closed }

enum AgentChatStatus { initial, loading, loaded, error }

class AgentChatState extends Equatable {
  final AgentChatStatus status;
  final AgentChatPhase phase;
  final ChatAgentEntity agent;
  final List<ChatMessageEntity> messages;
  final bool isTyping;
  final bool showScrollToBottom;
  final int agentReplyIndex;
  final String? errorMessage;

  const AgentChatState({
    this.status = AgentChatStatus.initial,
    this.phase = AgentChatPhase.connecting,
    this.agent = const ChatAgentEntity(
      id: 'agent_maggie',
      name: 'Maggy Lee',
      role: 'Customer Care Service',
      avatarUrl: 'assets/images/profile_picture.png',
    ),
    this.messages = const [],
    this.isTyping = false,
    this.showScrollToBottom = false,
    this.agentReplyIndex = 0,
    this.errorMessage,
  });

  AgentChatState copyWith({
    AgentChatStatus? status,
    AgentChatPhase? phase,
    ChatAgentEntity? agent,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
    bool? showScrollToBottom,
    int? agentReplyIndex,
    String? errorMessage,
  }) {
    return AgentChatState(
      status: status ?? this.status,
      phase: phase ?? this.phase,
      agent: agent ?? this.agent,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      showScrollToBottom: showScrollToBottom ?? this.showScrollToBottom,
      agentReplyIndex: agentReplyIndex ?? this.agentReplyIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        phase,
        agent,
        messages,
        isTyping,
        showScrollToBottom,
        agentReplyIndex,
        errorMessage,
      ];
}
