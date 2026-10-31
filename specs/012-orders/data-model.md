# Data Model: Orders Management, Tracking & Reviews

**Feature Directory**: `specs/012-orders`  
**Date**: 2026-10-03  
**Status**: Completed  

---

## 1. Domain Entities (`lib/features/orders/domain/entities/`)

### `OrderEntity`
Represents a customer order containing one or more purchased products, delivery logistics, and current lifecycle status.

```dart
class OrderEntity extends Equatable {
  final String id;
  final String orderNumber; // e.g. "Order #92287157"
  final List<OrderItemEntity> items;
  final String deliveryType; // e.g. "Standard Delivery"
  final int itemCount;
  final OrderStatus status; // packed, shipped, delivered, failedAttempt
  final String? trackingNumber; // e.g. "LGS-82736491"
  final DateTime createdAt;
  final DateTime? deliveredAt;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.deliveryType,
    required this.itemCount,
    required this.status,
    this.trackingNumber,
    required this.createdAt,
    this.deliveredAt,
  });

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        items,
        deliveryType,
        itemCount,
        status,
        trackingNumber,
        createdAt,
        deliveredAt,
      ];
}
```

### `OrderItemEntity`
Represents an individual line item inside an order.

```dart
class OrderItemEntity extends Equatable {
  final String id;
  final String orderId;
  final String productId;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String formattedDate; // e.g. "April, 06"
  final bool isReviewed;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.formattedDate,
    this.isReviewed = false,
  });

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        title,
        description,
        imageUrl,
        price,
        formattedDate,
        isReviewed,
      ];
}
```

### `TrackingStepEntity`
Represents a distinct fulfillment milestone within an order's tracking timeline.

```dart
class TrackingStepEntity extends Equatable {
  final String id;
  final String title; // e.g. "Packed", "On the Way to Logistic Facility"
  final String? timestamp; // e.g. "April 19 12:31"
  final bool isCompleted;
  final bool isFailed;
  final String iconType; // package, transit, facility, shipped, delivered, alert

  const TrackingStepEntity({
    required this.id,
    required this.title,
    this.timestamp,
    required this.isCompleted,
    this.isFailed = false,
    required this.iconType,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        timestamp,
        isCompleted,
        isFailed,
        iconType,
      ];
}
```

### `OrderReviewEntity`
Represents a customer review submitted for an individual item.

```dart
class OrderReviewEntity extends Equatable {
  final String id;
  final String orderId;
  final String itemId;
  final int rating; // 1 to 5
  final String comment;
  final DateTime submittedAt;

  const OrderReviewEntity({
    required this.id,
    required this.orderId,
    required this.itemId,
    required this.rating,
    required this.comment,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [
        id,
        orderId,
        itemId,
        rating,
        comment,
        submittedAt,
      ];
}
```

### Enums
```dart
enum OrderStatus {
  toPay,
  packed,
  shipped,
  delivered,
  failedAttempt,
}

enum OrderTab {
  toPay,
  toReceive,
  toReview,
}
```

---

## 2. Data Models (`lib/features/orders/data/models/`)

Each domain entity has a corresponding data model extending the entity with `fromJson`, `toJson`, and `fromEntity` factory methods:
- `OrderModel` extends `OrderEntity`
- `OrderItemModel` extends `OrderItemEntity`
- `TrackingStepModel` extends `TrackingStepEntity`
- `OrderReviewModel` extends `OrderReviewEntity`

---

## 3. Cubit States (`lib/features/orders/presentation/cubit/`)

### `OrdersState`
```dart
abstract class OrdersState extends Equatable {
  const OrdersState();
  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}
class OrdersLoading extends OrdersState {}
class OrdersLoaded extends OrdersState {
  final List<OrderEntity> allOrders;
  final OrderTab activeTab;
  final List<OrderEntity> filteredOrders;
  final List<OrderEntity> historyOrders;

  const OrdersLoaded({
    required this.allOrders,
    required this.activeTab,
    required this.filteredOrders,
    required this.historyOrders,
  });

  @override
  List<Object?> get props => [allOrders, activeTab, filteredOrders, historyOrders];
}
class OrdersError extends OrdersState {
  final String message;
  const OrdersError(this.message);
  @override
  List<Object?> get props => [message];
}
```

### `OrderTrackingState`
```dart
abstract class OrderTrackingState extends Equatable {
  const OrderTrackingState();
  @override
  List<Object?> get props => [];
}

class TrackingInitial extends OrderTrackingState {}
class TrackingLoading extends OrderTrackingState {}
class TrackingLoaded extends OrderTrackingState {
  final OrderEntity order;
  final List<TrackingStepEntity> steps;
  final bool hasFailedAttempt;
  final bool isDelivered;

  const TrackingLoaded({
    required this.order,
    required this.steps,
    this.hasFailedAttempt = false,
    this.isDelivered = false,
  });

  @override
  List<Object?> get props => [order, steps, hasFailedAttempt, isDelivered];
}
class TrackingError extends OrderTrackingState {
  final String message;
  const TrackingError(this.message);
  @override
  List<Object?> get props => [message];
}
```

### `OrderReviewState`
```dart
abstract class OrderReviewState extends Equatable {
  const OrderReviewState();
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends OrderReviewState {}
class ReviewItemsLoaded extends OrderReviewState {
  final String orderId;
  final List<OrderItemEntity> items;
  const ReviewItemsLoaded({required this.orderId, required this.items});
  @override
  List<Object?> get props => [orderId, items];
}
class ReviewEditing extends OrderReviewState {
  final OrderItemEntity item;
  final int rating;
  final String comment;
  final bool isSubmitting;
  const ReviewEditing({
    required this.item,
    this.rating = 5,
    this.comment = '',
    this.isSubmitting = false,
  });
  @override
  List<Object?> get props => [item, rating, comment, isSubmitting];
}
class ReviewSubmitted extends OrderReviewState {
  final OrderReviewEntity review;
  const ReviewSubmitted(this.review);
  @override
  List<Object?> get props => [review];
}
class ReviewError extends OrderReviewState {
  final String message;
  const ReviewError(this.message);
  @override
  List<Object?> get props => [message];
}
```

---

## 4. State Transitions & Lifecycle

```
[Orders Initial]
       │
       ▼ (loadOrders)
 [Orders Loading] ────────► [Orders Error]
       │
       ▼
  [Orders Loaded] ◄──────► (selectTab / filter)

[Tracking Initial]
       │
       ▼ (loadTracking)
[Tracking Loading] ───────► [Tracking Error]
       │
       ▼
[Tracking Loaded] (hasFailedAttempt? -> Screen 61 / isDelivered? -> Screen 63)

[Review Initial]
       │
       ▼ (loadItemsToReview)
[Review Items Loaded] (Screen 58)
       │
       ▼ (selectItem)
 [Review Editing] (Screen 66)
       │
       ▼ (submitReview)
[Review Submitted] ────────► [Review Done Dialog] (Screen 67)
```
