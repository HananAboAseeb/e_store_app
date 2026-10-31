import 'package:equatable/equatable.dart';

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

class OrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final List<OrderItemEntity> items;
  final String deliveryType;
  final int itemCount;
  final OrderStatus status;
  final String? trackingNumber;
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

class OrderItemEntity extends Equatable {
  final String id;
  final String orderId;
  final String productId;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String formattedDate;
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

class TrackingStepEntity extends Equatable {
  final String id;
  final String title;
  final String? timestamp;
  final bool isCompleted;
  final bool isFailed;
  final String iconType;

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

class OrderReviewEntity extends Equatable {
  final String id;
  final String orderId;
  final String itemId;
  final int rating;
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
