# Contracts: Orders Repository & UseCases

**Feature Directory**: `specs/012-orders`  
**Date**: 2026-10-03  
**Status**: Completed  

---

## 1. Domain Repository Contract (`lib/features/orders/domain/repositories/orders_repository.dart`)

```dart
abstract class OrdersRepository {
  /// Fetches orders filtered by active status tab (toPay, toReceive, toReview)
  Future<Either<Failure, List<OrderEntity>>> getOrders(OrderTab tab);

  /// Fetches historical completed orders (Screen 65)
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory();

  /// Fetches real-time tracking details and milestones for an order
  Future<Either<Failure, OrderEntity>> getOrderTracking(String orderId);

  /// Fetches tracking milestone steps for an order
  Future<Either<Failure, List<TrackingStepEntity>>> getTrackingSteps(String orderId);

  /// Fetches line items available for review on a completed order
  Future<Either<Failure, List<OrderItemEntity>>> getItemsToReview(String orderId);

  /// Submits a product review
  Future<Either<Failure, void>> submitReview(OrderReviewEntity review);
}
```

---

## 2. UseCases Contracts (`lib/features/orders/domain/usecases/`)

1. **`GetOrdersUseCase`**:
   - `Future<Either<Failure, List<OrderEntity>>> call(OrderTab tab);`
2. **`GetOrderHistoryUseCase`**:
   - `Future<Either<Failure, List<OrderEntity>>> call();`
3. **`GetOrderTrackingUseCase`**:
   - `Future<Either<Failure, Map<String, dynamic>>> call(String orderId);` (returns order + tracking steps)
4. **`GetItemsToReviewUseCase`**:
   - `Future<Either<Failure, List<OrderItemEntity>>> call(String orderId);`
5. **`SubmitReviewUseCase`**:
   - `Future<Either<Failure, void>> call(OrderReviewEntity review);`

---

## 3. Mock Data Source Contract (`lib/features/orders/data/datasources/orders_mock_datasource.dart`)

```dart
abstract class OrdersMockDataSource {
  Future<List<OrderModel>> getOrders(OrderTab tab);
  Future<List<OrderModel>> getOrderHistory();
  Future<OrderModel> getOrderTracking(String orderId);
  Future<List<TrackingStepModel>> getTrackingSteps(String orderId);
  Future<List<OrderItemModel>> getItemsToReview(String orderId);
  Future<void> submitReview(OrderReviewModel review);
}
```

### Mock Data Seed Specification:
- **5+ Orders**:
  1. `order-1`: `Order #92287157`, Status: `packed`, 3 items, Standard Delivery, Tracking: `LGS-92287157`
  2. `order-2`: `Order #89341204`, Status: `shipped`, 2 items, Standard Delivery, Tracking: `LGS-89341204`
  3. `order-3`: `Order #71829304`, Status: `failedAttempt`, 1 item, Standard Delivery, Tracking: `LGS-71829304`
  4. `order-4`: `Order #61092834`, Status: `delivered`, 3 items, Standard Delivery, Tracking: `LGS-61092834`, Delivered: `April 21 09:34`
  5. `order-5`: `Order #50192837`, Status: `toPay`, 2 items, Standard Delivery
- **Tracking Steps per Order**:
  - `order-1`: Packed (completed), On the way (completed), Arrived at facility (pending), Shipped (pending), Delivered (pending) -> Screen 59.
  - `order-3`: Packed (completed), On the way (completed), Arrived at facility (completed), Shipped (completed), Attempt to deliver was not successful (failed) -> Screen 61.
  - `order-4`: All 5 steps completed in blue -> Screen 63.
- **Review Items**:
  - At least 2 multi-item orders with items ready for review (Screen 58).
