import '../../domain/entities/shop_product_entity.dart';

class ShopProductModel extends ShopProductEntity {
  const ShopProductModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.price,
    super.originalPrice,
    super.isDiscounted,
    required super.category,
    required super.subCategory,
    super.sizes,
    super.colors,
    super.isPopular,
    required super.createdAt,
  });

  factory ShopProductModel.fromJson(Map<String, dynamic> json) {
    return ShopProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      isDiscounted: json['isDiscounted'] as bool? ?? false,
      category: json['category'] as String,
      subCategory: json['subCategory'] as String,
      sizes:
          (json['sizes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isPopular: json['isPopular'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'originalPrice': originalPrice,
      'isDiscounted': isDiscounted,
      'category': category,
      'subCategory': subCategory,
      'sizes': sizes,
      'colors': colors,
      'isPopular': isPopular,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
