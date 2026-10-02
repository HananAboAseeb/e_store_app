import '../../../home/data/models/home_data_model.dart';
import '../../../shop/data/models/shop_product_model.dart';
import '../models/recently_viewed_item_model.dart';
import '../models/wishlist_item_model.dart';
import 'wishlist_mock_datasource.dart';

class WishlistMockDataSourceImpl implements WishlistMockDataSource {
  // In-memory wishlist list to support removal
  final List<WishlistItemModel> _wishlistItems = [
    WishlistItemModel(
      id: 'wl_1',
      productId: 'shop_1',
      title: 'Lorem ipsum dolor sit amet consectetur',
      price: 17.00,
      imageUrl: 'assets/images/prod_20_1.png',
      color: 'Pink',
      size: 'M',
      addedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    WishlistItemModel(
      id: 'wl_2',
      productId: 'shop_2',
      title: 'Lorem ipsum dolor sit amet consectetur',
      price: 17.00,
      imageUrl: 'assets/images/prod_20_2.png',
      color: 'Pink',
      size: 'M',
      addedAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    WishlistItemModel(
      id: 'wl_3',
      productId: 'shop_3',
      title: 'Lorem ipsum dolor sit amet consectetur',
      price: 17.00,
      imageUrl: 'assets/images/prod_20_3.png',
      color: 'Pink',
      size: 'M',
      addedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    WishlistItemModel(
      id: 'wl_4',
      productId: 'shop_4',
      title: 'Lorem ipsum dolor sit amet consectetur',
      price: 17.00,
      imageUrl: 'assets/images/prod_20_4.png',
      color: 'Pink',
      size: 'M',
      addedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    WishlistItemModel(
      id: 'wl_5',
      productId: 'shop_5',
      title: 'Lorem ipsum dolor sit amet consectetur',
      price: 17.00,
      imageUrl: 'assets/images/prod_20_5.png',
      color: 'Pink',
      size: 'M',
      addedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  late final List<RecentlyViewedItemModel> _recentlyViewedItems;

  WishlistMockDataSourceImpl() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 10, 0);
    final yesterday = DateTime(now.year, now.month, now.day - 1, 15, 30);
    final april18 = DateTime(now.year, 4, 18, 12, 0);

    _recentlyViewedItems = [
      // Today items (3)
      RecentlyViewedItemModel(
        id: 'rv_1',
        product: ShopProductModel(
          id: 'shop_1',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 17.00,
          category: 'Clothing',
          subCategory: 'T-shirts',
          createdAt: today,
        ),
        viewedAt: today.add(const Duration(hours: 1)),
      ),
      RecentlyViewedItemModel(
        id: 'rv_2',
        product: ShopProductModel(
          id: 'shop_2',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_2.png',
          price: 17.00,
          category: 'Clothing',
          subCategory: 'T-shirts',
          createdAt: today,
        ),
        viewedAt: today.add(const Duration(hours: 2)),
      ),
      RecentlyViewedItemModel(
        id: 'rv_3',
        product: ShopProductModel(
          id: 'shop_3',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_3.png',
          price: 17.00,
          category: 'Clothing',
          subCategory: 'T-shirts',
          createdAt: today,
        ),
        viewedAt: today.add(const Duration(hours: 3)),
      ),
      // Yesterday items (3)
      RecentlyViewedItemModel(
        id: 'rv_4',
        product: ShopProductModel(
          id: 'shop_4',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_4.png',
          price: 17.00,
          category: 'Clothing',
          subCategory: 'Shirts',
          createdAt: yesterday,
        ),
        viewedAt: yesterday.add(const Duration(hours: 1)),
      ),
      RecentlyViewedItemModel(
        id: 'rv_5',
        product: ShopProductModel(
          id: 'shop_5',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_5.png',
          price: 17.00,
          category: 'Clothing',
          subCategory: 'Shirts',
          createdAt: yesterday,
        ),
        viewedAt: yesterday.add(const Duration(hours: 2)),
      ),
      RecentlyViewedItemModel(
        id: 'rv_6',
        product: ShopProductModel(
          id: 'shop_6',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_6.png',
          price: 17.00,
          category: 'Clothing',
          subCategory: 'Shirts',
          createdAt: yesterday,
        ),
        viewedAt: yesterday.add(const Duration(hours: 3)),
      ),
      // April 18 custom date items (2)
      RecentlyViewedItemModel(
        id: 'rv_7',
        product: ShopProductModel(
          id: 'shop_1',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 17.00,
          category: 'Clothing',
          subCategory: 'T-shirts',
          createdAt: april18,
        ),
        viewedAt: april18,
      ),
      RecentlyViewedItemModel(
        id: 'rv_8',
        product: ShopProductModel(
          id: 'shop_2',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_2.png',
          price: 17.00,
          category: 'Clothing',
          subCategory: 'T-shirts',
          createdAt: april18,
        ),
        viewedAt: april18.add(const Duration(hours: 2)),
      ),
    ];
  }

  @override
  Future<List<WishlistItemModel>> getWishlist() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_wishlistItems);
  }

  @override
  Future<void> removeFromWishlist(String itemId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _wishlistItems.removeWhere((item) => item.id == itemId);
  }

  @override
  Future<List<RecentlyViewedItemModel>> getRecentlyViewed() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_recentlyViewedItems);
  }

  @override
  Future<List<HomeProductModel>> getPopularProducts() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return const [
      HomeProductModel(
        id: 'pop_1',
        title: 'White Fur Jacket',
        price: 95.0,
        imageUrl: 'assets/images/jact.png',
        likeCount: 1780,
        tag: 'New',
      ),
      HomeProductModel(
        id: 'pop_2',
        title: 'Fur Jacket',
        price: 85.0,
        imageUrl: 'assets/images/jact.png',
        likeCount: 1780,
        tag: 'Sale',
      ),
      HomeProductModel(
        id: 'pop_3',
        title: 'Panda Coat',
        price: 65.0,
        imageUrl: 'assets/images/jact.png',
        likeCount: 1780,
        tag: 'Hot',
      ),
    ];
  }
}
