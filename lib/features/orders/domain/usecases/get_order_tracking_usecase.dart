import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class OrderTrackingData extends Equatable {
  final OrderEntity order;
  final List<TrackingStepEntity> steps;

  const OrderTrackingData({required this.order, required this.steps});

  @override
  List<Object?> get props => [order, steps];
}

class GetOrderTrackingUseCase implements UseCase<OrderTrackingData, String> {
  final OrdersRepository repository;

  GetOrderTrackingUseCase(this.repository);

  @override
  Future<Either<Failure, OrderTrackingData>> call([String? orderId]) async {
    final id = orderId ?? '';
    final orderResult = await repository.getOrderTracking(id);
    return orderResult.fold(
      (failure) => Left(failure),
      (order) async {
        final stepsResult = await repository.getTrackingSteps(id);
        return stepsResult.fold(
          (failure) => Left(failure),
          (steps) => Right(OrderTrackingData(order: order, steps: steps)),
        );
      },
    );
  }
}
