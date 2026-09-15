import 'package:equatable/equatable.dart';

class ShopProductEntity extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final bool isDiscounted;
  final String category;
  final String subCategory;
  final List<String> sizes;
  final List<String> colors;
  final bool isPopular;
  final DateTime createdAt;

  const ShopProductEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.isDiscounted = false,
    required this.category,
    required this.subCategory,
    this.sizes = const [],
    this.colors = const [],
    this.isPopular = false,
    required this.createdAt,
  });

  ShopProductEntity copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? price,
    double? originalPrice,
    bool? isDiscounted,
    String? category,
    String? subCategory,
    List<String>? sizes,
    List<String>? colors,
    bool? isPopular,
    DateTime? createdAt,
  }) {
    return ShopProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      isDiscounted: isDiscounted ?? this.isDiscounted,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      isPopular: isPopular ?? this.isPopular,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        price,
        originalPrice,
        isDiscounted,
        category,
        subCategory,
        sizes,
        colors,
        isPopular,
        createdAt,
      ];
}
