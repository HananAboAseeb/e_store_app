# Data Model: Product Feature (Screens 34, 35, 36, 37)

**Feature**: `specs/007-product` | **Date**: 2026-09-17

This document defines the domain entities, data models, state objects, and mapping relationships for the **Product** feature.

---

## 1. Domain Entities (`lib/features/product/domain/entities/`)

### 1.1 `ProductVariantEntity`
Represents a specific color/style variant of the product.
```dart
class ProductVariantEntity extends Equatable {
  final String id;
  final String name;       // e.g. "Red", "Purple", "Green"
  final String colorHex;   // e.g. "#D92D20", "#7A271A", "#027A48"
  final String thumbnailUrl;
  final List<String> images;

  const ProductVariantEntity({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.thumbnailUrl,
    required this.images,
  });

  @override
  List<Object?> get props => [id, name, colorHex, thumbnailUrl, images];
}
```

### 1.2 `SpecificationEntity`
Represents technical product specifications.
```dart
class SpecificationEntity extends Equatable {
  final String label;       // e.g. "Material", "Origin"
  final List<String> values; // e.g. ["Cotton: 95%", "Nylon: 5%"] or ["EUROPE"]

  const SpecificationEntity({
    required this.label,
    required this.values,
  });

  @override
  List<Object?> get props => [label, values];
}
```

### 1.3 `DeliveryOptionEntity`
Represents a shipping option tier.
```dart
class DeliveryOptionEntity extends Equatable {
  final String id;
  final String name;        // e.g. "Standard", "Express"
  final String estimatedDays; // e.g. "5 - 7 Days", "1 - 2 Days"
  final double price;       // e.g. 3.00, 12.00

  const DeliveryOptionEntity({
    required this.id,
    required this.name,
    required this.estimatedDays,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, estimatedDays, price];
}
```

### 1.4 `RatingBreakdownEntity`
Represents the star breakdown score distribution.
```dart
class RatingBreakdownEntity extends Equatable {
  final int stars;          // 5, 4, 3, 2, 1
  final double percentage;  // 0.0 to 1.0 (e.g. 0.20 for 20%)

  const RatingBreakdownEntity({
    required this.stars,
    required this.percentage,
  });

  @override
  List<Object?> get props => [stars, percentage];
}
```

### 1.5 `ReviewEntity`
Represents an individual customer review.
```dart
class ReviewEntity extends Equatable {
  final String id;
  final String authorName;   // e.g. "Veronica"
  final String authorAvatar; // asset path or network URL
  final double rating;       // e.g. 4.0
  final String text;
  final int likes;
  final int dislikes;
  final bool? userVote;      // true = liked, false = disliked, null = none
  final String timeAgo;      // e.g. "2 Days Ago"

  const ReviewEntity({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.rating,
    required this.text,
    required this.likes,
    required this.dislikes,
    this.userVote,
    required this.timeAgo,
  });

  ReviewEntity copyWith({
    int? likes,
    int? dislikes,
    bool? Function()? userVote,
  }) { ... }

  @override
  List<Object?> get props => [id, authorName, authorAvatar, rating, text, likes, dislikes, userVote, timeAgo];
}
```

### 1.6 `ProductDetailsEntity`
Represents the complete product details page data.
```dart
class ProductDetailsEntity extends Equatable {
  final String id;
  final String title;               // e.g. "Caviar Leather Jacket"
  final List<String> breadcrumb;    // e.g. ["Shop", "Jackets", "Caviar"]
  final double rating;              // e.g. 4.7
  final int reviewCount;            // e.g. 2986
  final int scoreCount;             // e.g. 3654
  final double basePrice;           // e.g. 24.00
  final double? salePrice;          // e.g. 17.00
  final int? discountPercent;       // e.g. 20 (-20%)
  final bool isFlashSale;           // true if actively on flash sale
  final int flashSaleRemainingSeconds; // e.g. 2218 seconds (00:36:58)
  final List<ProductVariantEntity> variants;
  final List<String> availableSizes; // ["XS", "S", "M", "L", "XL", "2XL"]
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
    id, title, breadcrumb, rating, reviewCount, scoreCount,
    basePrice, salePrice, discountPercent, isFlashSale,
    flashSaleRemainingSeconds, variants, availableSizes,
    specifications, deliveryOptions, ratingsBreakdown,
    reviewsPreview, mostPopularProducts, youMightLikeProducts,
  ];
}
```

---

## 2. Data Models (`lib/features/product/data/models/`)

Each entity has a corresponding model with `fromJson`, `toJson`, and domain mapping:
1. `ProductVariantModel` extends `ProductVariantEntity`
2. `SpecificationModel` extends `SpecificationEntity`
3. `DeliveryOptionModel` extends `DeliveryOptionEntity`
4. `RatingBreakdownModel` extends `RatingBreakdownEntity`
5. `ReviewModel` extends `ReviewEntity`
6. `ProductDetailsModel` extends `ProductDetailsEntity`

---

## 3. Cubit States (`lib/features/product/presentation/cubit/`)

### 3.1 `ProductDetailsState`
```dart
abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
}

class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsEntity product;
  final int selectedVariantIndex;
  final String selectedSize;
  final bool isWishlisted;
  final int remainingSeconds;
  final bool isFlashSaleActive;

  const ProductDetailsLoaded({
    required this.product,
    required this.selectedVariantIndex,
    required this.selectedSize,
    required this.isWishlisted,
    required this.remainingSeconds,
    required this.isFlashSaleActive,
  });

  ProductVariantEntity get activeVariant => product.variants[selectedVariantIndex];
  List<String> get activeImages => activeVariant.images;
  double get currentPrice => isFlashSaleActive ? (product.salePrice ?? product.basePrice) : product.basePrice;

  ProductDetailsLoaded copyWith({ ... });

  @override
  List<Object?> get props => [
    product, selectedVariantIndex, selectedSize,
    isWishlisted, remainingSeconds, isFlashSaleActive,
  ];
}

class ProductDetailsError extends ProductDetailsState {
  final Failure failure;
  const ProductDetailsError(this.failure);
  @override
  List<Object?> get props => [failure];
}
```

### 3.2 `ReviewsState`
```dart
abstract class ReviewsState extends Equatable {
  const ReviewsState();
  @override
  List<Object?> get props => [];
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

class ReviewsLoaded extends ReviewsState {
  final List<ReviewEntity> reviews;
  final bool hasMore;
  final int page;

  const ReviewsLoaded({
    required this.reviews,
    required this.hasMore,
    required this.page,
  });

  ReviewsLoaded copyWith({ ... });

  @override
  List<Object?> get props => [reviews, hasMore, page];
}

class ReviewsError extends ReviewsState {
  final Failure failure;
  const ReviewsError(this.failure);
  @override
  List<Object?> get props => [failure];
}
```
