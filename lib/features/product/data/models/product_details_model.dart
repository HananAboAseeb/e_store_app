import '../../../shop/data/models/shop_product_model.dart';
import '../../domain/entities/product_details_entity.dart';
import 'delivery_option_model.dart';
import 'product_variant_model.dart';
import 'rating_breakdown_model.dart';
import 'review_model.dart';
import 'specification_model.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required super.id,
    required super.title,
    required super.breadcrumb,
    required super.rating,
    required super.reviewCount,
    required super.scoreCount,
    required super.basePrice,
    super.salePrice,
    super.discountPercent,
    required super.isFlashSale,
    required super.flashSaleRemainingSeconds,
    required super.variants,
    required super.availableSizes,
    required super.specifications,
    required super.deliveryOptions,
    required super.ratingsBreakdown,
    required super.reviewsPreview,
    required super.mostPopularProducts,
    required super.youMightLikeProducts,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      breadcrumb: (json['breadcrumb'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      scoreCount: json['scoreCount'] as int? ?? 0,
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      discountPercent: json['discountPercent'] as int?,
      isFlashSale: json['isFlashSale'] as bool? ?? false,
      flashSaleRemainingSeconds: json['flashSaleRemainingSeconds'] as int? ?? 0,
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) =>
                  ProductVariantModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      availableSizes: (json['availableSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      specifications: (json['specifications'] as List<dynamic>?)
              ?.map(
                  (e) => SpecificationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      deliveryOptions: (json['deliveryOptions'] as List<dynamic>?)
              ?.map((e) =>
                  DeliveryOptionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ratingsBreakdown: (json['ratingsBreakdown'] as List<dynamic>?)
              ?.map((e) =>
                  RatingBreakdownModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      reviewsPreview: (json['reviewsPreview'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      mostPopularProducts: (json['mostPopularProducts'] as List<dynamic>?)
              ?.map((e) => ShopProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      youMightLikeProducts: (json['youMightLikeProducts'] as List<dynamic>?)
              ?.map((e) => ShopProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'breadcrumb': breadcrumb,
      'rating': rating,
      'reviewCount': reviewCount,
      'scoreCount': scoreCount,
      'basePrice': basePrice,
      'salePrice': salePrice,
      'discountPercent': discountPercent,
      'isFlashSale': isFlashSale,
      'flashSaleRemainingSeconds': flashSaleRemainingSeconds,
      'variants': variants
          .map((e) => ProductVariantModel.fromEntity(e).toJson())
          .toList(),
      'availableSizes': availableSizes,
      'specifications': specifications
          .map((e) => SpecificationModel.fromEntity(e).toJson())
          .toList(),
      'deliveryOptions': deliveryOptions
          .map((e) => DeliveryOptionModel.fromEntity(e).toJson())
          .toList(),
      'ratingsBreakdown': ratingsBreakdown
          .map((e) => RatingBreakdownModel.fromEntity(e).toJson())
          .toList(),
      'reviewsPreview': reviewsPreview
          .map((e) => ReviewModel.fromEntity(e).toJson())
          .toList(),
      'mostPopularProducts': mostPopularProducts.map((e) {
        if (e is ShopProductModel) return e.toJson();
        return {
          'id': e.id,
          'title': e.title,
          'imageUrl': e.imageUrl,
          'price': e.price,
          'originalPrice': e.originalPrice,
          'isDiscounted': e.isDiscounted,
          'category': e.category,
          'subCategory': e.subCategory,
          'sizes': e.sizes,
          'colors': e.colors,
          'isPopular': e.isPopular,
          'createdAt': e.createdAt.toIso8601String(),
        };
      }).toList(),
      'youMightLikeProducts': youMightLikeProducts.map((e) {
        if (e is ShopProductModel) return e.toJson();
        return {
          'id': e.id,
          'title': e.title,
          'imageUrl': e.imageUrl,
          'price': e.price,
          'originalPrice': e.originalPrice,
          'isDiscounted': e.isDiscounted,
          'category': e.category,
          'subCategory': e.subCategory,
          'sizes': e.sizes,
          'colors': e.colors,
          'isPopular': e.isPopular,
          'createdAt': e.createdAt.toIso8601String(),
        };
      }).toList(),
    };
  }
}
