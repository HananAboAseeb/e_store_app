import '../../domain/entities/activity_summary_entity.dart';
import 'category_spending_model.dart';
import 'order_stats_model.dart';

class ActivitySummaryModel extends ActivitySummaryEntity {
  const ActivitySummaryModel({
    required super.month,
    required super.year,
    required super.totalAmount,
    required super.categories,
    required super.orderStats,
  });

  factory ActivitySummaryModel.fromJson(Map<String, dynamic> json) {
    return ActivitySummaryModel(
      month: json['month'] as String,
      year: json['year'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategorySpendingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStats:
          OrderStatsModel.fromJson(json['orderStats'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'year': year,
      'totalAmount': totalAmount,
      'categories':
          categories.map((e) => (e as CategorySpendingModel).toJson()).toList(),
      'orderStats': (orderStats as OrderStatsModel).toJson(),
    };
  }

  factory ActivitySummaryModel.fromEntity(ActivitySummaryEntity entity) {
    return ActivitySummaryModel(
      month: entity.month,
      year: entity.year,
      totalAmount: entity.totalAmount,
      categories: entity.categories,
      orderStats: entity.orderStats,
    );
  }
}
