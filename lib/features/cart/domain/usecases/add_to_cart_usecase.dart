import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/cart_item_entity.dart';
import '../entities/cart_summary_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase implements UseCase<CartSummaryEntity, CartItemEntity> {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call([CartItemEntity? param]) {
    if (param == null) {
      return Future.value(const Left(ServerFailure('Item must not be null')));
    }
    return repository.addItem(param);
  }
}
