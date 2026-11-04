import 'package:equatable/equatable.dart';

class ChatAgentEntity extends Equatable {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;

  const ChatAgentEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, role, avatarUrl];
}
