import '../../domain/entities/chat_order_summary_entity.dart';

class ChatOrderSummaryModel extends ChatOrderSummaryEntity {
  const ChatOrderSummaryModel({
    required super.id,
    required super.orderNumber,
    required super.deliveryType,
    required super.itemCount,
    required super.status,
    required super.thumbnailUrl,
    super.isSelected = false,
  });

  factory ChatOrderSummaryModel.fromEntity(ChatOrderSummaryEntity entity) {
    return ChatOrderSummaryModel(
      id: entity.id,
      orderNumber: entity.orderNumber,
      deliveryType: entity.deliveryType,
      itemCount: entity.itemCount,
      status: entity.status,
      thumbnailUrl: entity.thumbnailUrl,
      isSelected: entity.isSelected,
    );
  }

  factory ChatOrderSummaryModel.fromMap(Map<String, dynamic> map) {
    return ChatOrderSummaryModel(
      id: map['id'] as String? ?? '',
      orderNumber: map['orderNumber'] as String? ?? '',
      deliveryType: map['deliveryType'] as String? ?? '',
      itemCount: map['itemCount'] as int? ?? 0,
      status: map['status'] as String? ?? '',
      thumbnailUrl: map['thumbnailUrl'] as String? ?? '',
      isSelected: map['isSelected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'deliveryType': deliveryType,
      'itemCount': itemCount,
      'status': status,
      'thumbnailUrl': thumbnailUrl,
      'isSelected': isSelected,
    };
  }
}
