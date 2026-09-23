import 'package:equatable/equatable.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';
import 'cart_item_entity.dart';
import 'shipping_address_entity.dart';

class CartSummaryEntity extends Equatable {
  final List<CartItemEntity> items;
  final List<CartItemEntity> wishlistSuggestions;
  final List<ShopProductEntity> popularSuggestions;
  final ShippingAddressEntity? shippingAddress;

  const CartSummaryEntity({
    required this.items,
    required this.wishlistSuggestions,
    required this.popularSuggestions,
    this.shippingAddress,
  });

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get itemCount => items.length;

  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;

  CartSummaryEntity copyWith({
    List<CartItemEntity>? items,
    List<CartItemEntity>? wishlistSuggestions,
    List<ShopProductEntity>? popularSuggestions,
    ShippingAddressEntity? shippingAddress,
  }) {
    return CartSummaryEntity(
      items: items ?? this.items,
      wishlistSuggestions: wishlistSuggestions ?? this.wishlistSuggestions,
      popularSuggestions: popularSuggestions ?? this.popularSuggestions,
      shippingAddress: shippingAddress ?? this.shippingAddress,
    );
  }

  @override
  List<Object?> get props => [
        items,
        wishlistSuggestions,
        popularSuggestions,
        shippingAddress,
      ];
}
