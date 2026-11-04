import 'package:equatable/equatable.dart';

import '../../../profile/domain/entities/voucher_entity.dart';
import 'chat_order_summary_entity.dart';

enum ChatAttachmentType { order, voucher }

class ChatAttachmentEntity extends Equatable {
  final ChatAttachmentType type;
  final ChatOrderSummaryEntity? order;
  final VoucherEntity? voucher;

  const ChatAttachmentEntity({
    required this.type,
    this.order,
    this.voucher,
  });

  @override
  List<Object?> get props => [type, order, voucher];
}
