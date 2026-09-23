import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/cart_summary_entity.dart';
import '../repositories/cart_repository.dart';

class RemoveWishlistSuggestionUseCase
    implements UseCase<CartSummaryEntity, String> {
  final CartRepository repository;

  RemoveWishlistSuggestionUseCase(this.repository);

  @override
  Future<Either<Failure, CartSummaryEntity>> call([String? param]) {
    return repository.removeWishlistSuggestion(param ?? '');
  }
}
