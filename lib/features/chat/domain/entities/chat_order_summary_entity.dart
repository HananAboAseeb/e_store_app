import 'package:equatable/equatable.dart';

class ChatOrderSummaryEntity extends Equatable {
  final String id;
  final String orderNumber;
  final String deliveryType;
  final int itemCount;
  final String status;
  final String thumbnailUrl;
  final bool isSelected;

  const ChatOrderSummaryEntity({
    required this.id,
    required this.orderNumber,
    required this.deliveryType,
    required this.itemCount,
    required this.status,
    required this.thumbnailUrl,
    this.isSelected = false,
  });

  ChatOrderSummaryEntity copyWith({
    String? id,
    String? orderNumber,
    String? deliveryType,
    int? itemCount,
    String? status,
    String? thumbnailUrl,
    bool? isSelected,
  }) {
    return ChatOrderSummaryEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      deliveryType: deliveryType ?? this.deliveryType,
      itemCount: itemCount ?? this.itemCount,
      status: status ?? this.status,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        deliveryType,
        itemCount,
        status,
        thumbnailUrl,
        isSelected,
      ];
}
