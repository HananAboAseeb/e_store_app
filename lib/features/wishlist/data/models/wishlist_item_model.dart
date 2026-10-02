import '../../domain/entities/wishlist_item_entity.dart';

class WishlistItemModel extends WishlistItemEntity {
  const WishlistItemModel({
    required super.id,
    required super.productId,
    required super.title,
    required super.price,
    required super.imageUrl,
    required super.color,
    required super.size,
    required super.addedAt,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      color: json['color'] as String,
      size: json['size'] as String,
      addedAt: DateTime.parse(json['added_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'title': title,
        'price': price,
        'image_url': imageUrl,
        'color': color,
        'size': size,
        'added_at': addedAt.toIso8601String(),
      };
}
