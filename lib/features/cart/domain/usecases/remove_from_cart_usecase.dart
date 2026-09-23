import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/cart_summary_entity.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase implements UseCase<CartSummaryEntity, String> {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call([String? param]) {
    return repository.removeItem(param ?? '');
  }
}
