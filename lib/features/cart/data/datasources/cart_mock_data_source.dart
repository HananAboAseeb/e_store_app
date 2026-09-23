import '../models/cart_item_model.dart';
import '../models/cart_summary_model.dart';

abstract class CartMockDataSource {
  Future<CartSummaryModel> getCart();
  Future<CartSummaryModel> addItem(CartItemModel item);
  Future<CartSummaryModel> removeItem(String itemId);
  Future<CartSummaryModel> updateQuantity(String itemId, int quantity);
  Future<CartSummaryModel> removeWishlistSuggestion(String itemId);
  Future<CartSummaryModel> clearCart();
}
