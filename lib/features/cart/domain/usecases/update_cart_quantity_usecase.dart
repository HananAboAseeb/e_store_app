import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/cart_summary_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateCartQuantityParams extends Equatable {
  final String itemId;
  final int quantity;

  const UpdateCartQuantityParams({
    required this.itemId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [itemId, quantity];
}

class UpdateCartQuantityUseCase
    implements UseCase<CartSummaryEntity, UpdateCartQuantityParams> {
  final CartRepository repository;

  UpdateCartQuantityUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call(
      [UpdateCartQuantityParams? param]) {
    if (param == null) {
      return Future.value(const Left(ServerFailure('Params must not be null')));
    }
    return repository.updateQuantity(param.itemId, param.quantity);
  }
}
