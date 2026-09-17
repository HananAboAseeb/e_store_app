import '../../../shop/data/models/shop_product_model.dart';
import '../../domain/entities/image_search_result_entity.dart';

class ImageSearchResultModel extends ImageSearchResultEntity {
  const ImageSearchResultModel({
    required super.id,
    required super.imagePath,
    required super.detectedCategory,
    required super.confidence,
    required super.products,
  });

  factory ImageSearchResultModel.fromJson(Map<String, dynamic> json) {
    return ImageSearchResultModel(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      detectedCategory: json['detectedCategory'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      products: (json['products'] as List<dynamic>)
          .map((p) => ShopProductModel.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'detectedCategory': detectedCategory,
      'confidence': confidence,
      'products': products.map((p) {
        if (p is ShopProductModel) return p.toJson();
        return ShopProductModel(
          id: p.id,
          title: p.title,
          imageUrl: p.imageUrl,
          price: p.price,
          originalPrice: p.originalPrice,
          isDiscounted: p.isDiscounted,
          category: p.category,
          subCategory: p.subCategory,
          sizes: p.sizes,
          colors: p.colors,
          isPopular: p.isPopular,
          createdAt: p.createdAt,
        ).toJson();
      }).toList(),
    };
  }

  factory ImageSearchResultModel.fromEntity(ImageSearchResultEntity entity) {
    return ImageSearchResultModel(
      id: entity.id,
      imagePath: entity.imagePath,
      detectedCategory: entity.detectedCategory,
      confidence: entity.confidence,
      products: entity.products,
    );
  }
}
