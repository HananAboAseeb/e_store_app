import 'package:equatable/equatable.dart';
import 'category_spending_entity.dart';
import 'order_stats_entity.dart';

class ActivitySummaryEntity extends Equatable {
  final String month;
  final int year;
  final double totalAmount;
  final List<CategorySpendingEntity> categories;
  final OrderStatsEntity orderStats;

  const ActivitySummaryEntity({
    required this.month,
    required this.year,
    required this.totalAmount,
    required this.categories,
    required this.orderStats,
  });

  @override
  List<Object?> get props => [month, year, totalAmount, categories, orderStats];
}
