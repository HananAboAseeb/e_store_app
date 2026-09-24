import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final String id;
  final String productId;
  final String title;
  final String imageUrl;
  final int quantity;
  final String size;
  final String color;
  final double unitPrice;

  const OrderItemEntity({
    required this.id,
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.size,
    required this.color,
    required this.unitPrice,
  });

  double get totalPrice => unitPrice * quantity;

  @override
  List<Object?> get props => [
        id,
        productId,
        title,
        imageUrl,
        quantity,
        size,
        color,
        unitPrice,
      ];
}
