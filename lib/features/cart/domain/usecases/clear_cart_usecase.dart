import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/cart_summary_entity.dart';
import '../repositories/cart_repository.dart';

class ClearCartUseCase implements UseCase<CartSummaryEntity, NoParam> {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call([NoParam? param]) {
    return repository.clearCart();
  }
}
