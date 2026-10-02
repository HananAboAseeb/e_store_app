import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../../../home/domain/entities/home_data_entity.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlistPopularProductsUseCase
    implements UseCase<List<HomeProductEntity>, NoParam> {
  final WishlistRepository repository;

  GetWishlistPopularProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<HomeProductEntity>>> call([NoParam? param]) {
    return repository.getPopularProducts();
  }
}
