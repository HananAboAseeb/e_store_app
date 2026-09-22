import 'package:equatable/equatable.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';
import 'delivery_option_entity.dart';
import 'product_variant_entity.dart';
import 'rating_breakdown_entity.dart';
import 'review_entity.dart';
import 'specification_entity.dart';

class ProductDetailsEntity extends Equatable {
  final String id;
  final String title;
  final List<String> breadcrumb;
  final double rating;
  final int reviewCount;
  final int scoreCount;
  final double basePrice;
  final double? salePrice;
  final int? discountPercent;
  final bool isFlashSale;
  final int flashSaleRemainingSeconds;
  final List<ProductVariantEntity> variants;
  final List<String> availableSizes;
  final List<SpecificationEntity> specifications;
  final List<DeliveryOptionEntity> deliveryOptions;
  final List<RatingBreakdownEntity> ratingsBreakdown;
  final List<ReviewEntity> reviewsPreview;
  final List<ShopProductEntity> mostPopularProducts;
  final List<ShopProductEntity> youMightLikeProducts;

  const ProductDetailsEntity({
    required this.id,
    required this.title,
    required this.breadcrumb,
    required this.rating,
    required this.reviewCount,
    required this.scoreCount,
    required this.basePrice,
    this.salePrice,
    this.discountPercent,
    required this.isFlashSale,
    required this.flashSaleRemainingSeconds,
    required this.variants,
    required this.availableSizes,
    required this.specifications,
    required this.deliveryOptions,
    required this.ratingsBreakdown,
    required this.reviewsPreview,
    required this.mostPopularProducts,
    required this.youMightLikeProducts,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        breadcrumb,
        rating,
        reviewCount,
        scoreCount,
        basePrice,
        salePrice,
        discountPercent,
        isFlashSale,
        flashSaleRemainingSeconds,
        variants,
        availableSizes,
        specifications,
        deliveryOptions,
        ratingsBreakdown,
        reviewsPreview,
        mostPopularProducts,
        youMightLikeProducts,
      ];
}
