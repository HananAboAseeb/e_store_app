import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetItemsToReviewUseCase
    implements UseCase<List<OrderItemEntity>, String> {
  final OrdersRepository repository;

  GetItemsToReviewUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderItemEntity>>> call([String? orderId]) {
    return repository.getItemsToReview(orderId ?? '');
  }
}
