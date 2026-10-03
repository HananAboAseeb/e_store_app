import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrderHistoryUseCase implements UseCase<List<OrderEntity>, NoParam> {
  final OrdersRepository repository;

  GetOrderHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call([NoParam? param]) {
    return repository.getOrderHistory();
  }
}
