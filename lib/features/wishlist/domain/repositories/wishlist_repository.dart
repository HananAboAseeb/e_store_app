import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/home_data_entity.dart';
import '../entities/recently_viewed_item_entity.dart';
import '../entities/wishlist_item_entity.dart';

abstract class WishlistRepository {
  /// Fetches all active wishlist items for the current user.
  Future<Either<Failure, List<WishlistItemEntity>>> getWishlist();

  /// Removes an item from the wishlist by its unique item ID.
  Future<Either<Failure, void>> removeFromWishlist(String itemId);

  /// Moves or adds an item from the wishlist into the shopping cart.
  Future<Either<Failure, void>> addToCart(WishlistItemEntity item);

  /// Fetches recently viewed products, optionally filtered by a specific date.
  Future<Either<Failure, List<RecentlyViewedItemEntity>>> getRecentlyViewed({
    DateTime? date,
  });

  /// Fetches popular products for the empty wishlist recommendation section.
  Future<Either<Failure, List<HomeProductEntity>>> getPopularProducts();
}
