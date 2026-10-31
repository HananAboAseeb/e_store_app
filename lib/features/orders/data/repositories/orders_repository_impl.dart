import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_mock_datasource.dart';
import '../models/order_model.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersMockDataSource mockDataSource;

  OrdersRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders(OrderTab tab) async {
    return await safeCall(() => mockDataSource.getOrders(tab));
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory() async {
    return await safeCall(() => mockDataSource.getOrderHistory());
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderTracking(String orderId) async {
    return await safeCall(() => mockDataSource.getOrderTracking(orderId));
  }

  @override
  Future<Either<Failure, List<TrackingStepEntity>>> getTrackingSteps(
      String orderId) async {
    return await safeCall(() => mockDataSource.getTrackingSteps(orderId));
  }

  @override
  Future<Either<Failure, List<OrderItemEntity>>> getItemsToReview(
      String orderId) async {
    return await safeCall(() => mockDataSource.getItemsToReview(orderId));
  }

  @override
  Future<Either<Failure, void>> submitReview(OrderReviewEntity review) async {
    return await safeCall(
      () => mockDataSource.submitReview(OrderReviewModel.fromEntity(review)),
    );
  }
}
