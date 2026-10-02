import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/domain/repositories/cart_repository.dart';
import '../../../home/domain/entities/home_data_entity.dart';
import '../../domain/entities/recently_viewed_item_entity.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_mock_datasource.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistMockDataSource mockDataSource;
  final CartRepository? cartRepository;

  WishlistRepositoryImpl({
    required this.mockDataSource,
    this.cartRepository,
  });

  @override
  Future<Either<Failure, List<WishlistItemEntity>>> getWishlist() async {
    return await safeCall(() => mockDataSource.getWishlist());
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(String itemId) async {
    return await safeCall(() => mockDataSource.removeFromWishlist(itemId));
  }

  @override
  Future<Either<Failure, void>> addToCart(WishlistItemEntity item) async {
    return await safeCall(() async {
      if (cartRepository != null) {
        await cartRepository!.addItem(
          CartItemEntity(
            id: 'cart_${item.id}',
            productId: item.productId,
            title: item.title,
            imageUrl: item.imageUrl,
            size: item.size,
            color: item.color,
            quantity: 1,
            unitPrice: item.price,
          ),
        );
      }
    });
  }

  @override
  Future<Either<Failure, List<RecentlyViewedItemEntity>>> getRecentlyViewed({
    DateTime? date,
  }) async {
    return await safeCall(() async {
      final items = await mockDataSource.getRecentlyViewed();
      if (date != null) {
        return items.where((item) {
          return item.viewedAt.year == date.year &&
              item.viewedAt.month == date.month &&
              item.viewedAt.day == date.day;
        }).toList();
      }
      return items;
    });
  }

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getPopularProducts() async {
    return await safeCall(() => mockDataSource.getPopularProducts());
  }
}
