import '../../../shop/data/models/shop_product_model.dart';
import '../models/cart_item_model.dart';
import '../models/cart_summary_model.dart';
import '../models/shipping_address_model.dart';
import 'cart_mock_data_source.dart';

class CartMockDataSourceImpl implements CartMockDataSource {
  final List<CartItemModel> _cartItems = [
    const CartItemModel(
      id: 'cart-item-1',
      productId: 'prod-cloth-1',
      title: 'Lorem ipsum dolor sit amet consectetur.',
      imageUrl: 'assets/images/cat_cloth_1.png',
      size: 'M',
      color: 'Pink',
      quantity: 1,
      unitPrice: 17.00,
    ),
    const CartItemModel(
      id: 'cart-item-2',
      productId: 'prod-hoodie-1',
      title: 'Lorem ipsum dolor sit amet consectetur.',
      imageUrl: 'assets/images/cat_hoodie_1.png',
      size: 'M',
      color: 'Pink',
      quantity: 1,
      unitPrice: 17.00,
    ),
  ];

  final List<CartItemModel> _wishlistSuggestions = [
    const CartItemModel(
      id: 'wishlist-1',
      productId: 'prod-bag-1',
      title: 'Lorem ipsum dolor sit amet consectetur.',
      imageUrl: 'assets/images/cat_bag_1.png',
      size: 'M',
      color: 'Pink',
      quantity: 1,
      unitPrice: 17.00,
    ),
    const CartItemModel(
      id: 'wishlist-2',
      productId: 'prod-cloth-2',
      title: 'Lorem ipsum dolor sit amet consectetur.',
      imageUrl: 'assets/images/cat_cloth_2.png',
      size: 'M',
      color: 'Pink',
      quantity: 1,
      unitPrice: 17.00,
    ),
    const CartItemModel(
      id: 'wishlist-3',
      productId: 'prod-hoodie-2',
      title: 'Lorem ipsum dolor sit amet consectetur.',
      imageUrl: 'assets/images/cat_hoodie_2.png',
      size: 'M',
      color: 'Pink',
      quantity: 1,
      unitPrice: 17.00,
    ),
  ];

  final List<ShopProductModel> _popularSuggestions = [
    ShopProductModel(
      id: 'caviar-jacket',
      title: 'Caviar Leather Jacket',
      imageUrl: 'assets/images/jact.png',
      price: 17.80,
      originalPrice: 24.00,
      isDiscounted: true,
      category: 'jackets',
      subCategory: 'leather',
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ShopProductModel(
      id: 'home-flash-1',
      title: 'Classic Pink Hoodie',
      imageUrl: 'assets/images/home_flash_1.png',
      price: 17.80,
      isDiscounted: false,
      category: 'hoodies',
      subCategory: 'casual',
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ShopProductModel(
      id: 'home-flash-2',
      title: 'Urban Denim Jacket',
      imageUrl: 'assets/images/home_flash_2.png',
      price: 17.80,
      originalPrice: 22.00,
      isDiscounted: true,
      category: 'jackets',
      subCategory: 'denim',
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ShopProductModel(
      id: 'home-flash-3',
      title: 'Vintage Leather Bag',
      imageUrl: 'assets/images/home_flash_3.png',
      price: 17.80,
      isDiscounted: false,
      category: 'bags',
      subCategory: 'vintage',
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  final ShippingAddressModel _shippingAddress = const ShippingAddressModel(
    id: 'addr-1',
    country: 'United States',
    city: 'New York',
    state: 'NY',
    street: '110 W 44th Street',
    zipCode: '10036',
  );

  Future<void> _simulateLatency() async {
    await Future.delayed(const Duration(milliseconds: 150));
  }

  CartSummaryModel _buildSummary() {
    return CartSummaryModel(
      items: List.unmodifiable(_cartItems),
      wishlistSuggestions: List.unmodifiable(_wishlistSuggestions),
      popularSuggestions: List.unmodifiable(_popularSuggestions),
      shippingAddress: _shippingAddress,
    );
  }

  @override
  Future<CartSummaryModel> getCart() async {
    await _simulateLatency();
    return _buildSummary();
  }

  @override
  Future<CartSummaryModel> addItem(CartItemModel item) async {
    await _simulateLatency();
    final index = _cartItems.indexWhere(
      (existing) =>
          existing.productId == item.productId &&
          existing.size == item.size &&
          existing.color == item.color,
    );

    if (index >= 0) {
      final existing = _cartItems[index];
      _cartItems[index] = existing.copyWith(
        quantity: existing.quantity + item.quantity,
      ) as CartItemModel;
    } else {
      _cartItems.add(item);
    }

    return _buildSummary();
  }

  @override
  Future<CartSummaryModel> removeItem(String itemId) async {
    await _simulateLatency();
    _cartItems.removeWhere((item) => item.id == itemId);
    return _buildSummary();
  }

  @override
  Future<CartSummaryModel> updateQuantity(String itemId, int quantity) async {
    await _simulateLatency();
    final effectiveQuantity = quantity < 1 ? 1 : quantity;
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      final existing = _cartItems[index];
      _cartItems[index] = CartItemModel(
        id: existing.id,
        productId: existing.productId,
        title: existing.title,
        imageUrl: existing.imageUrl,
        size: existing.size,
        color: existing.color,
        quantity: effectiveQuantity,
        unitPrice: existing.unitPrice,
      );
    }
    return _buildSummary();
  }

  @override
  Future<CartSummaryModel> removeWishlistSuggestion(String itemId) async {
    await _simulateLatency();
    _wishlistSuggestions.removeWhere((item) => item.id == itemId);
    return _buildSummary();
  }

  @override
  Future<CartSummaryModel> clearCart() async {
    await _simulateLatency();
    _cartItems.clear();
    return _buildSummary();
  }
}
