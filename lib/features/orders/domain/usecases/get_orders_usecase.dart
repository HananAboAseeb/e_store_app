import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase implements UseCase<List<OrderEntity>, OrderTab> {
  final OrdersRepository repository;

  GetOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call([OrderTab? param]) {
    return repository.getOrders(param ?? OrderTab.toReceive);
  }
}
