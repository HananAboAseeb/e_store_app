import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/recently_viewed_item_entity.dart';
import '../repositories/wishlist_repository.dart';

class GetRecentlyViewedUseCase
    implements UseCase<List<RecentlyViewedItemEntity>, DateTime?> {
  final WishlistRepository repository;

  GetRecentlyViewedUseCase(this.repository);

  @override
  Future<Either<Failure, List<RecentlyViewedItemEntity>>> call([
    DateTime? date,
  ]) {
    return repository.getRecentlyViewed(date: date);
  }
}
