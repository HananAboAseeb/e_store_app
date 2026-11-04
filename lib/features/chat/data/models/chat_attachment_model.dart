import '../../../profile/data/models/voucher_model.dart';
import '../../domain/entities/chat_attachment_entity.dart';
import 'chat_order_summary_model.dart';

class ChatAttachmentModel extends ChatAttachmentEntity {
  const ChatAttachmentModel({
    required super.type,
    super.order,
    super.voucher,
  });

  factory ChatAttachmentModel.fromMap(Map<String, dynamic> map) {
    final typeStr = map['type'] as String? ?? 'order';
    final type = typeStr == 'voucher'
        ? ChatAttachmentType.voucher
        : ChatAttachmentType.order;

    return ChatAttachmentModel(
      type: type,
      order: map['order'] != null
          ? ChatOrderSummaryModel.fromMap(map['order'] as Map<String, dynamic>)
          : null,
      voucher: map['voucher'] != null
          ? VoucherModel.fromJson(map['voucher'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type == ChatAttachmentType.voucher ? 'voucher' : 'order',
      'order': order != null
          ? ChatOrderSummaryModel.fromEntity(order!).toMap()
          : null,
      'voucher':
          voucher != null ? VoucherModel.fromEntity(voucher!).toJson() : null,
    };
  }
}
