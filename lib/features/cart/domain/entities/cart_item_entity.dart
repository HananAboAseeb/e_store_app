import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String id;
  final String productId;
  final String title;
  final String imageUrl;
  final String size;
  final String color;
  final int quantity;
  final double unitPrice;

  const CartItemEntity({
    required this.id,
    required this.productId,
    required this.title,
    required this.imageUrl,
    this.size = 'M',
    this.color = 'Pink',
    this.quantity = 1,
    required this.unitPrice,
  });

  double get totalPrice => unitPrice * quantity;

  CartItemEntity copyWith({
    String? id,
    String? productId,
    String? title,
    String? imageUrl,
    String? size,
    String? color,
    int? quantity,
    double? unitPrice,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        title,
        imageUrl,
        size,
        color,
        quantity,
        unitPrice,
      ];
}
