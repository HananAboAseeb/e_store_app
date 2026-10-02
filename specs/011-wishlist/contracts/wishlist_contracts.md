# Phase 1: Contracts — Wishlist & Recently Viewed

**Feature Directory**: `specs/011-wishlist`  
**Date**: 2026-09-29  
**Status**: Completed  

---

## 1. Repository Contract (Domain Layer)

```dart
abstract class WishlistRepository {
  /// Fetches all active wishlist items for the current user.
  Future<Either<Failure, List<WishlistItemEntity>>> getWishlist();

  /// Removes an item from the wishlist by its unique item ID.
  Future<Either<Failure, void>> removeFromWishlist(String itemId);

  /// Moves or adds an item from the wishlist into the shopping cart.
  Future<Either<Failure, void>> addToCart(WishlistItemEntity item);

  /// Fetches recently viewed products, optionally filtered by a specific date.
  Future<Either<Failure, List<RecentlyViewedItemEntity>>> getRecentlyViewed({
    DateTime? date,
  });

  /// Fetches popular products for the empty wishlist recommendation section.
  Future<Either<Failure, List<HomeProductEntity>>> getPopularProducts();
}
```

---

## 2. Mock Data Source Contract (Data Layer)

```dart
abstract class WishlistMockDataSource {
  /// Returns the current list of mock wishlist items.
  Future<List<WishlistItemModel>> getWishlist();

  /// Removes an item from the in-memory mock wishlist.
  Future<void> removeFromWishlist(String itemId);

  /// Returns recently viewed items.
  Future<List<RecentlyViewedItemModel>> getRecentlyViewed();

  /// Returns popular products.
  Future<List<HomeProductModel>> getPopularProducts();
}
```

---

## 3. Use Cases (Domain Layer)

1. **`GetWishlistUseCase`**:
   - Signature: `Future<Either<Failure, List<WishlistItemEntity>>> call([NoParams? params])`
2. **`RemoveFromWishlistUseCase`**:
   - Signature: `Future<Either<Failure, void>> call(String itemId)`
3. **`AddToCartFromWishlistUseCase`**:
   - Signature: `Future<Either<Failure, void>> call(WishlistItemEntity item)`
4. **`GetRecentlyViewedUseCase`**:
   - Signature: `Future<Either<Failure, List<RecentlyViewedItemEntity>>> call([DateTime? date])`
5. **`GetWishlistPopularProductsUseCase`**:
   - Signature: `Future<Either<Failure, List<HomeProductEntity>>> call([NoParams? params])`

---

## 4. Shared Widget Contracts

### `ProductItemRow` (`lib/shared/widgets/product_item_row.dart`)
```dart
class ProductItemRow extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final List<Widget> metaPills;
  final VoidCallback onDelete;
  final Widget trailingAction;
  final VoidCallback? onTap;

  const ProductItemRow({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.metaPills,
    required this.onDelete,
    required this.trailingAction,
    this.onTap,
  });
}
```

### `MetaPill` (`lib/shared/widgets/meta_pill.dart`)
```dart
class MetaPill extends StatelessWidget {
  final String text;

  const MetaPill({
    super.key,
    required this.text,
  });
}
```
