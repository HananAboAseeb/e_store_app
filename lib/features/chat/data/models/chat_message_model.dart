import '../../domain/entities/chat_message_entity.dart';
import 'chat_attachment_model.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.id,
    required super.sender,
    required super.text,
    required super.timestamp,
    super.attachment,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    final senderStr = map['sender'] as String? ?? 'bot';
    final sender = senderStr == 'user'
        ? ChatMessageSender.user
        : (senderStr == 'agent'
            ? ChatMessageSender.agent
            : ChatMessageSender.bot);

    return ChatMessageModel(
      id: map['id'] as String? ?? '',
      sender: sender,
      text: map['text'] as String? ?? '',
      timestamp: map['timestamp'] as String? ?? '',
      attachment: map['attachment'] != null
          ? ChatAttachmentModel.fromMap(
              map['attachment'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender.name,
      'text': text,
      'timestamp': timestamp,
      'attachment': attachment != null
          ? (attachment is ChatAttachmentModel
              ? (attachment as ChatAttachmentModel).toMap()
              : ChatAttachmentModel(
                  type: attachment!.type,
                  order: attachment!.order,
                  voucher: attachment!.voucher,
                ).toMap())
          : null,
    };
  }
}
