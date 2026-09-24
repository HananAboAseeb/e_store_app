import '../../domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.productId,
    required super.title,
    required super.imageUrl,
    required super.quantity,
    required super.size,
    required super.color,
    required super.unitPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      size: json['size'] as String? ?? 'M',
      color: json['color'] as String? ?? 'Pink',
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'size': size,
      'color': color,
      'unitPrice': unitPrice,
    };
  }

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      id: entity.id,
      productId: entity.productId,
      title: entity.title,
      imageUrl: entity.imageUrl,
      quantity: entity.quantity,
      size: entity.size,
      color: entity.color,
      unitPrice: entity.unitPrice,
    );
  }

  OrderItemEntity toEntity() => this;
}
