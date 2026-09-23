# Interface Contracts: Cart Feature (Screens 44, 45, 46)

**Feature**: `specs/008-cart` | **Date**: 2026-09-23

This document formalizes the interface contracts across Clean Architecture layers for the **Cart** feature.

---

## 1. Domain Repository Contract (`lib/features/cart/domain/repositories/cart_repository.dart`)

```dart
abstract class CartRepository {
  /// Fetches current cart summary including active items, suggestions, and shipping address.
  Future<Either<Failure, CartSummaryEntity>> getCart();

  /// Adds a new item or increments quantity if item already exists with matching size/color.
  Future<Either<Failure, CartSummaryEntity>> addItem(CartItemEntity item);

  /// Removes an item completely from the cart.
  Future<Either<Failure, CartSummaryEntity>> removeItem(String itemId);

  /// Updates quantity of an existing item (enforces min: 1).
  Future<Either<Failure, CartSummaryEntity>> updateQuantity(String itemId, int quantity);

  /// Removes an item from the wishlist suggestions section.
  Future<Either<Failure, CartSummaryEntity>> removeWishlistSuggestion(String itemId);

  /// Clears all items from the cart.
  Future<Either<Failure, CartSummaryEntity>> clearCart();
}
```

---

## 2. Domain UseCases (`lib/features/cart/domain/usecases/`)

```dart
class GetCartUseCase implements UseCase<CartSummaryEntity, NoParams> {
  final CartRepository repository;
  GetCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call(NoParams params) {
    return repository.getCart();
  }
}

class AddToCartUseCase implements UseCase<CartSummaryEntity, CartItemEntity> {
  final CartRepository repository;
  AddToCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call(CartItemEntity item) {
    return repository.addItem(item);
  }
}

class RemoveFromCartUseCase implements UseCase<CartSummaryEntity, String> {
  final CartRepository repository;
  RemoveFromCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call(String itemId) {
    return repository.removeItem(itemId);
  }
}

class UpdateCartQuantityParams extends Equatable {
  final String itemId;
  final int quantity;
  const UpdateCartQuantityParams({required this.itemId, required this.quantity});

  @override
  List<Object?> get props => [itemId, quantity];
}

class UpdateCartQuantityUseCase implements UseCase<CartSummaryEntity, UpdateCartQuantityParams> {
  final CartRepository repository;
  UpdateCartQuantityUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call(UpdateCartQuantityParams params) {
    return repository.updateQuantity(params.itemId, params.quantity);
  }
}

class RemoveWishlistSuggestionUseCase implements UseCase<CartSummaryEntity, String> {
  final CartRepository repository;
  RemoveWishlistSuggestionUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call(String itemId) {
    return repository.removeWishlistSuggestion(itemId);
  }
}

class ClearCartUseCase implements UseCase<CartSummaryEntity, NoParams> {
  final CartRepository repository;
  ClearCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call(NoParams params) {
    return repository.clearCart();
  }
}
```

---

## 3. Data Source Contract (`lib/features/cart/data/datasources/cart_mock_data_source.dart`)

```dart
abstract class CartMockDataSource {
  Future<CartSummaryModel> getCart();
  Future<CartSummaryModel> addItem(CartItemModel item);
  Future<CartSummaryModel> removeItem(String itemId);
  Future<CartSummaryModel> updateQuantity(String itemId, int quantity);
  Future<CartSummaryModel> removeWishlistSuggestion(String itemId);
  Future<CartSummaryModel> clearCart();
}
```

---

## 4. Presentation Cubit Contract (`lib/features/cart/presentation/manager/cart_cubit.dart`)

```dart
abstract class CartCubitContract {
  Future<void> loadCart();
  Future<void> incrementQuantity(String itemId);
  Future<void> decrementQuantity(String itemId);
  Future<void> removeItem(String itemId);
  Future<void> addProductToCart(ShopProductEntity product, {String? size, String? color});
  Future<void> addCartItem(CartItemEntity item);
  Future<void> removeFromWishlist(String itemId);
  Future<void> clearCart();
}
```
