import 'package:equatable/equatable.dart';

import 'chat_attachment_entity.dart';

enum ChatMessageSender { bot, user, agent }

class ChatMessageEntity extends Equatable {
  final String id;
  final ChatMessageSender sender;
  final String text;
  final String timestamp;
  final ChatAttachmentEntity? attachment;

  const ChatMessageEntity({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    this.attachment,
  });

  @override
  List<Object?> get props => [id, sender, text, timestamp, attachment];
}
