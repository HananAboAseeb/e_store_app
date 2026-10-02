import '../../../home/data/models/home_data_model.dart';
import '../models/recently_viewed_item_model.dart';
import '../models/wishlist_item_model.dart';

abstract class WishlistMockDataSource {
  /// Returns the current list of mock wishlist items.
  Future<List<WishlistItemModel>> getWishlist();

  /// Removes an item from the in-memory mock wishlist.
  Future<void> removeFromWishlist(String itemId);

  /// Returns recently viewed items.
  Future<List<RecentlyViewedItemModel>> getRecentlyViewed();

  /// Returns popular products for recommendations.
  Future<List<HomeProductModel>> getPopularProducts();
}
