import 'package:equatable/equatable.dart';

class WishlistItemEntity extends Equatable {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final String color;
  final String size;
  final DateTime addedAt;

  const WishlistItemEntity({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.color,
    required this.size,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        title,
        price,
        imageUrl,
        color,
        size,
        addedAt,
      ];
}
