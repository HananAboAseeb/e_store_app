import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../repositories/wishlist_repository.dart';

class RemoveFromWishlistUseCase implements UseCase<void, String> {
  final WishlistRepository repository;

  RemoveFromWishlistUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call([String? itemId]) {
    if (itemId == null) {
      return Future.value(
        const Left(ServerFailure('Item ID must not be null')),
      );
    }
    return repository.removeFromWishlist(itemId);
  }
}
