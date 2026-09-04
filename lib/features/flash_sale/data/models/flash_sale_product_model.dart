import '../../domain/entities/flash_sale_product_entity.dart';

class FlashSaleProductModel extends FlashSaleProductEntity {
  const FlashSaleProductModel({
    required super.id,
    required super.title,
    required super.currentPrice,
    required super.originalPrice,
    required super.imageUrl,
    required super.discountPercentage,
    super.likeCount,
    super.tag,
  });

  factory FlashSaleProductModel.fromJson(Map<String, dynamic> json) {
    return FlashSaleProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      discountPercentage: json['discountPercentage'] as int,
      likeCount: json['likeCount'] as int?,
      tag: json['tag'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'currentPrice': currentPrice,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'discountPercentage': discountPercentage,
      'likeCount': likeCount,
      'tag': tag,
    };
  }
}
