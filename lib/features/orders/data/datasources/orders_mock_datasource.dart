import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';

abstract class OrdersMockDataSource {
  Future<List<OrderModel>> getOrders(OrderTab tab);
  Future<List<OrderModel>> getOrderHistory();
  Future<OrderModel> getOrderTracking(String orderId);
  Future<List<TrackingStepModel>> getTrackingSteps(String orderId);
  Future<List<OrderItemModel>> getItemsToReview(String orderId);
  Future<void> submitReview(OrderReviewModel review);
}
