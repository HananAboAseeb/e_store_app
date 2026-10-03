import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.orderNumber,
    required super.items,
    required super.deliveryType,
    required super.itemCount,
    required super.status,
    super.trackingNumber,
    required super.createdAt,
    super.deliveredAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) =>
                  OrderItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      deliveryType: json['deliveryType'] as String? ?? 'Standard Delivery',
      itemCount: json['itemCount'] as int? ?? 1,
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.packed,
      ),
      trackingNumber: json['trackingNumber'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'items': items
          .map((item) => OrderItemModel.fromEntity(item).toJson())
          .toList(),
      'deliveryType': deliveryType,
      'itemCount': itemCount,
      'status': status.name,
      'trackingNumber': trackingNumber,
      'createdAt': createdAt.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      orderNumber: entity.orderNumber,
      items: entity.items,
      deliveryType: entity.deliveryType,
      itemCount: entity.itemCount,
      status: entity.status,
      trackingNumber: entity.trackingNumber,
      createdAt: entity.createdAt,
      deliveredAt: entity.deliveredAt,
    );
  }
}

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.orderId,
    required super.productId,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.price,
    required super.formattedDate,
    super.isReviewed = false,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String,
      orderId: json['orderId'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      formattedDate: json['formattedDate'] as String? ?? '',
      isReviewed: json['isReviewed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'formattedDate': formattedDate,
      'isReviewed': isReviewed,
    };
  }

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      id: entity.id,
      orderId: entity.orderId,
      productId: entity.productId,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      price: entity.price,
      formattedDate: entity.formattedDate,
      isReviewed: entity.isReviewed,
    );
  }
}

class TrackingStepModel extends TrackingStepEntity {
  const TrackingStepModel({
    required super.id,
    required super.title,
    super.timestamp,
    required super.isCompleted,
    super.isFailed = false,
    required super.iconType,
  });

  factory TrackingStepModel.fromJson(Map<String, dynamic> json) {
    return TrackingStepModel(
      id: json['id'] as String,
      title: json['title'] as String,
      timestamp: json['timestamp'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isFailed: json['isFailed'] as bool? ?? false,
      iconType: json['iconType'] as String? ?? 'package',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'timestamp': timestamp,
      'isCompleted': isCompleted,
      'isFailed': isFailed,
      'iconType': iconType,
    };
  }

  factory TrackingStepModel.fromEntity(TrackingStepEntity entity) {
    return TrackingStepModel(
      id: entity.id,
      title: entity.title,
      timestamp: entity.timestamp,
      isCompleted: entity.isCompleted,
      isFailed: entity.isFailed,
      iconType: entity.iconType,
    );
  }
}

class OrderReviewModel extends OrderReviewEntity {
  const OrderReviewModel({
    required super.id,
    required super.orderId,
    required super.itemId,
    required super.rating,
    required super.comment,
    required super.submittedAt,
  });

  factory OrderReviewModel.fromJson(Map<String, dynamic> json) {
    return OrderReviewModel(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      itemId: json['itemId'] as String,
      rating: json['rating'] as int? ?? 5,
      comment: json['comment'] as String? ?? '',
      submittedAt: json['submittedAt'] != null
          ? DateTime.parse(json['submittedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'itemId': itemId,
      'rating': rating,
      'comment': comment,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  factory OrderReviewModel.fromEntity(OrderReviewEntity entity) {
    return OrderReviewModel(
      id: entity.id,
      orderId: entity.orderId,
      itemId: entity.itemId,
      rating: entity.rating,
      comment: entity.comment,
      submittedAt: entity.submittedAt,
    );
  }
}
