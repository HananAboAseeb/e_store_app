# Data Model: Cart Feature (Screens 44, 45, 46)

**Feature**: `specs/008-cart` | **Date**: 2026-09-23

This document defines the domain entities, data transfer models, and UI state representations for the **Cart** feature.

---

## 1. Domain Entities (`lib/features/cart/domain/entities/`)

### `CartItemEntity`
Represents an individual line item inside the shopping cart.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique line item identifier (e.g., `cart-item-1`) |
| `productId` | `String` | Product reference identifier |
| `title` | `String` | Product title (e.g., "Lorem ipsum dolor sit amet...") |
| `imageUrl` | `String` | Asset path for product thumbnail |
| `size` | `String` | Selected variant size (e.g., "M") |
| `color` | `String` | Selected variant color (e.g., "Pink") |
| `quantity` | `int` | Current quantity (min: 1) |
| `unitPrice` | `double` | Price per single unit (e.g., 17.00) |
| `totalPrice` | `double` | Computed: `unitPrice * quantity` |

### `ShippingAddressEntity`
Represents the default delivery destination displayed on Screen 44.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique address identifier |
| `country` | `String` | Country name (e.g., "United States") |
| `city` | `String` | City name (e.g., "New York") |
| `state` | `String` | State code/name (e.g., "NY") |
| `street` | `String` | Street address (e.g., "110 W 44th Street") |
| `zipCode` | `String` | Postal code (e.g., "10036") |
| `formattedAddress` | `String` | Computed or formatted summary string |

### `CartSummaryEntity`
Aggregate root entity representing the full cart state.

| Field | Type | Description |
|---|---|---|
| `items` | `List<CartItemEntity>` | List of active items in the cart |
| `wishlistSuggestions` | `List<CartItemEntity>` | Saved items available for quick addition |
| `popularSuggestions` | `List<ShopProductEntity>` | Recommended popular items for discovery |
| `shippingAddress` | `ShippingAddressEntity?` | Default destination address |
| `subtotal` | `double` | Computed: $\sum(\text{item.totalPrice})$ |
| `itemCount` | `int` | Computed: total distinct items count for header badge |

---

## 2. Data Models (`lib/features/cart/data/models/`)

### `CartItemModel`
Extends `CartItemEntity`. Provides JSON serialization (`fromJson`, `toJson`) and conversion methods:
- `factory CartItemModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`
- `factory CartItemModel.fromEntity(CartItemEntity entity)`
- `CartItemEntity toEntity()`

### `ShippingAddressModel`
Extends `ShippingAddressEntity`. Provides JSON serialization:
- `factory ShippingAddressModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`
- `factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity)`
- `ShippingAddressEntity toEntity()`

### `CartSummaryModel`
Extends `CartSummaryEntity`. Provides JSON serialization:
- `factory CartSummaryModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`
- `factory CartSummaryModel.fromEntity(CartSummaryEntity entity)`
- `CartSummaryEntity toEntity()`

---

## 3. Presentation State (`lib/features/cart/presentation/manager/`)

### `CartState` (sealed / extends `Equatable`)

```dart
abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;
  final List<CartItemEntity> wishlistSuggestions;
  final List<ShopProductEntity> popularSuggestions;
  final ShippingAddressEntity? shippingAddress;
  final double subtotal;
  final int itemCount;

  const CartLoaded({
    required this.items,
    required this.wishlistSuggestions,
    required this.popularSuggestions,
    this.shippingAddress,
    required this.subtotal,
    required this.itemCount,
  });

  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [
    items,
    wishlistSuggestions,
    popularSuggestions,
    shippingAddress,
    subtotal,
    itemCount,
  ];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
```
