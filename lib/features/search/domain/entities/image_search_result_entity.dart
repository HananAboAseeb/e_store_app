import 'package:equatable/equatable.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';

class ImageSearchResultEntity extends Equatable {
  final String id;
  final String imagePath;
  final String detectedCategory;
  final double confidence;
  final List<ShopProductEntity> products;

  const ImageSearchResultEntity({
    required this.id,
    required this.imagePath,
    required this.detectedCategory,
    required this.confidence,
    required this.products,
  });

  @override
  List<Object?> get props => [
        id,
        imagePath,
        detectedCategory,
        confidence,
        products,
      ];
}
