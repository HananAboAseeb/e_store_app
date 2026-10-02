# Phase 1: Data Model — Wishlist & Recently Viewed

**Feature Directory**: `specs/011-wishlist`  
**Date**: 2026-09-29  
**Status**: Completed  

---

## 1. Domain Entities

### `WishlistItemEntity`
Represents an individual product saved to the user's wishlist with selected variants.
```dart
class WishlistItemEntity extends Equatable {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final String color;
  final String size;
  final DateTime addedAt;

  const WishlistItemEntity({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.color,
    required this.size,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        title,
        price,
        imageUrl,
        color,
        size,
        addedAt,
      ];
}
```

### `RecentlyViewedItemEntity`
Represents a product viewed by the user, linked to a timestamp for date-based grouping.
```dart
class RecentlyViewedItemEntity extends Equatable {
  final String id;
  final ShopProductEntity product;
  final DateTime viewedAt;

  const RecentlyViewedItemEntity({
    required this.id,
    required this.product,
    required this.viewedAt,
  });

  @override
  List<Object?> get props => [id, product, viewedAt];
}
```

### `DateTabEntity`
Represents a selectable date filter tab in the Recently Viewed screen.
```dart
class DateTabEntity extends Equatable {
  final String id;
  final String label;
  final DateTime? date;
  final bool isPreset; // true for Today / Yesterday, false for custom picked date

  const DateTabEntity({
    required this.id,
    required this.label,
    this.date,
    this.isPreset = true,
  });

  @override
  List<Object?> get props => [id, label, date, isPreset];
}
```

---

## 2. Data Models (with JSON / Factory mapping)

### `WishlistItemModel`
Extends `WishlistItemEntity`:
```dart
class WishlistItemModel extends WishlistItemEntity {
  const WishlistItemModel({
    required super.id,
    required super.productId,
    required super.title,
    required super.price,
    required super.imageUrl,
    required super.color,
    required super.size,
    required super.addedAt,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      color: json['color'] as String,
      size: json['size'] as String,
      addedAt: DateTime.parse(json['added_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'title': title,
        'price': price,
        'image_url': imageUrl,
        'color': color,
        'size': size,
        'added_at': addedAt.toIso8601String(),
      };
}
```

### `RecentlyViewedItemModel`
Extends `RecentlyViewedItemEntity`:
```dart
class RecentlyViewedItemModel extends RecentlyViewedItemEntity {
  const RecentlyViewedItemModel({
    required super.id,
    required super.product,
    required super.viewedAt,
  });

  factory RecentlyViewedItemModel.fromEntity(RecentlyViewedItemEntity entity) {
    return RecentlyViewedItemModel(
      id: entity.id,
      product: entity.product,
      viewedAt: entity.viewedAt,
    );
  }
}
```

---

## 3. Cubit State Models

### `WishlistState`
- `WishlistInitial`: Initial mounting state.
- `WishlistLoading`: Displays `WishlistShimmerLoading`.
- `WishlistLoaded`: Holds `List<WishlistItemEntity> items`.
- `WishlistEmpty`: Holds `List<HomeProductEntity> popularProducts`.
- `WishlistError`: Holds error `message`.

### `RecentlyViewedState`
- `RecentlyViewedInitial`: Initial state.
- `RecentlyViewedLoading`: Displays `RecentlyViewedShimmerLoading`.
- `RecentlyViewedLoaded`: Holds:
  - `List<DateTabEntity> tabs` (Today, Yesterday, and optional custom date)
  - `String activeTabId` (id of the active tab)
  - `List<ShopProductEntity> filteredProducts` (products matching the selected date)
  - `bool isCalendarExpanded` (controls inline calendar visibility)
  - `DateTime selectedCalendarDate` (highlighted date in calendar)
  - `DateTime displayedMonth` (month shown in calendar navigation)
- `RecentlyViewedError`: Holds error `message`.
