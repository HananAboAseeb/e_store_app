import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';

abstract class OrdersRepository {
  /// Fetches orders filtered by active status tab (toPay, toReceive, toReview)
  Future<Either<Failure, List<OrderEntity>>> getOrders(OrderTab tab);

  /// Fetches historical completed orders (Screen 65)
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory();

  /// Fetches real-time tracking details for an order
  Future<Either<Failure, OrderEntity>> getOrderTracking(String orderId);

  /// Fetches tracking milestone steps for an order
  Future<Either<Failure, List<TrackingStepEntity>>> getTrackingSteps(
      String orderId);

  /// Fetches line items available for review on a completed order
  Future<Either<Failure, List<OrderItemEntity>>> getItemsToReview(
      String orderId);

  /// Submits a product review
  Future<Either<Failure, void>> submitReview(OrderReviewEntity review);
}
