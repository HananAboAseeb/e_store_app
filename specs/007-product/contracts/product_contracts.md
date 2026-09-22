# Component Contracts: Product Feature (Screens 34, 35, 36, 37)

**Feature**: `specs/007-product` | **Date**: 2026-09-17

This document defines the formal interfaces and API contracts across Domain, Data, and Presentation layers for the **Product** feature.

---

## 1. Domain Layer Contracts

### 1.1 Repository Contract (`lib/features/product/domain/repositories/product_repository.dart`)
```dart
abstract class ProductRepository {
  /// Fetches detailed product information by ID.
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(String id);

  /// Fetches paginated reviews for a given product.
  Future<Either<Failure, List<ReviewEntity>>> getProductReviews(
    String productId, {
    int page = 1,
    int limit = 10,
  });

  /// Submits an optimistic like/dislike vote for a review.
  Future<Either<Failure, ReviewEntity>> voteReview(
    String reviewId, {
    required bool isLike,
  });
}
```

### 1.2 Use Cases (`lib/features/product/domain/usecases/`)

#### `GetProductDetailsUseCase`
```dart
class GetProductDetailsUseCase implements UseCase<ProductDetailsEntity, String> {
  final ProductRepository repository;
  GetProductDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductDetailsEntity>> call(String id) {
    return repository.getProductDetails(id);
  }
}
```

#### `GetProductReviewsUseCase`
```dart
class GetProductReviewsParams extends Equatable {
  final String productId;
  final int page;
  final int limit;

  const GetProductReviewsParams({
    required this.productId,
    this.page = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [productId, page, limit];
}

class GetProductReviewsUseCase
    implements UseCase<List<ReviewEntity>, GetProductReviewsParams> {
  final ProductRepository repository;
  GetProductReviewsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ReviewEntity>>> call(GetProductReviewsParams params) {
    return repository.getProductReviews(
      params.productId,
      page: params.page,
      limit: params.limit,
    );
  }
}
```

#### `VoteReviewUseCase`
```dart
class VoteReviewParams extends Equatable {
  final String reviewId;
  final bool isLike;

  const VoteReviewParams({required this.reviewId, required this.isLike});

  @override
  List<Object?> get props => [reviewId, isLike];
}

class VoteReviewUseCase implements UseCase<ReviewEntity, VoteReviewParams> {
  final ProductRepository repository;
  VoteReviewUseCase(this.repository);

  @override
  Future<Either<Failure, ReviewEntity>> call(VoteReviewParams params) {
    return repository.voteReview(params.reviewId, isLike: params.isLike);
  }
}
```

---

## 2. Data Layer Contracts (`lib/features/product/data/datasources/`)

### `ProductMockDataSource`
```dart
abstract class ProductMockDataSource {
  Future<ProductDetailsModel> getProductDetails(String id);
  Future<List<ReviewModel>> getProductReviews(String productId, {int page = 1, int limit = 10});
  Future<ReviewModel> voteReview(String reviewId, {required bool isLike});
}
```

---

## 3. Presentation Layer Cubit Contracts (`lib/features/product/presentation/cubit/`)

### 3.1 `ProductDetailsCubit`
```dart
abstract class ProductDetailsCubitContract {
  Future<void> loadProduct(String id);
  void selectColorVariant(int index);
  void selectSize(String size);
  void toggleWishlist();
  void addToBasket();
}
```

### 3.2 `ReviewsCubit`
```dart
abstract class ReviewsCubitContract {
  Future<void> loadReviews(String productId);
  Future<void> loadMoreReviews();
  void toggleLike(String reviewId);
  void toggleDislike(String reviewId);
}
```

---

## 4. Routing Contracts (`lib/config/routing/`)

### Route Names (`route_names.dart`)
- `RouteNames.kProductDetailsPage = '/product/:id'`
- `RouteNames.kProductReviewsPage = '/product/:id/reviews'`

### URL Structure & Parameter Contracts
- `/product/caviar-jacket`: Loads product details with standard view.
- `/product/caviar-jacket?sale=true`: Loads product details with active flash sale banner and countdown timer.
- `/product/caviar-jacket/reviews`: Loads full reviews screen for the specified product.
