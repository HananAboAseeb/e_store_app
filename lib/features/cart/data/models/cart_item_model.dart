import '../../domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.productId,
    required super.title,
    required super.imageUrl,
    super.size = 'M',
    super.color = 'Pink',
    super.quantity = 1,
    required super.unitPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      productId: json['productId'] as String? ?? json['id'] as String,
      title: json['title'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      size: json['size'] as String? ?? 'M',
      color: json['color'] as String? ?? 'Pink',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'imageUrl': imageUrl,
      'size': size,
      'color': color,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      id: entity.id,
      productId: entity.productId,
      title: entity.title,
      imageUrl: entity.imageUrl,
      size: entity.size,
      color: entity.color,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      productId: productId,
      title: title,
      imageUrl: imageUrl,
      size: size,
      color: color,
      quantity: quantity,
      unitPrice: unitPrice,
    );
  }
}
