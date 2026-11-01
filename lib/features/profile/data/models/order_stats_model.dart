import '../../domain/entities/order_stats_entity.dart';

class OrderStatsModel extends OrderStatsEntity {
  const OrderStatsModel({
    required super.orderedCount,
    required super.receivedCount,
    required super.toReceiveCount,
  });

  factory OrderStatsModel.fromJson(Map<String, dynamic> json) {
    return OrderStatsModel(
      orderedCount: json['orderedCount'] as int? ?? 0,
      receivedCount: json['receivedCount'] as int? ?? 0,
      toReceiveCount: json['toReceiveCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderedCount': orderedCount,
      'receivedCount': receivedCount,
      'toReceiveCount': toReceiveCount,
    };
  }

  factory OrderStatsModel.fromEntity(OrderStatsEntity entity) {
    return OrderStatsModel(
      orderedCount: entity.orderedCount,
      receivedCount: entity.receivedCount,
      toReceiveCount: entity.toReceiveCount,
    );
  }
}
