import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/wishlist_item_entity.dart';
import '../repositories/wishlist_repository.dart';

class AddToCartFromWishlistUseCase
    implements UseCase<void, WishlistItemEntity> {
  final WishlistRepository repository;

  AddToCartFromWishlistUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call([WishlistItemEntity? item]) {
    if (item == null) {
      return Future.value(const Left(ServerFailure('Item must not be null')));
    }
    return repository.addToCart(item);
  }
}
