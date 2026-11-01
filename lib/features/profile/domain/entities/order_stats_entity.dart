import 'package:equatable/equatable.dart';

class OrderStatsEntity extends Equatable {
  final int orderedCount;
  final int receivedCount;
  final int toReceiveCount;

  const OrderStatsEntity({
    required this.orderedCount,
    required this.receivedCount,
    required this.toReceiveCount,
  });

  @override
  List<Object?> get props => [orderedCount, receivedCount, toReceiveCount];
}
