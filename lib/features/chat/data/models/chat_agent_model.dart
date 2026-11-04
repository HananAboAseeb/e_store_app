import '../../domain/entities/chat_agent_entity.dart';

class ChatAgentModel extends ChatAgentEntity {
  const ChatAgentModel({
    required super.id,
    required super.name,
    required super.role,
    required super.avatarUrl,
  });

  factory ChatAgentModel.fromMap(Map<String, dynamic> map) {
    return ChatAgentModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      role: map['role'] as String? ?? '',
      avatarUrl: map['avatarUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'avatarUrl': avatarUrl,
    };
  }
}
