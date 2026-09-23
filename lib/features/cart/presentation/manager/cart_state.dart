import 'package:equatable/equatable.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/cart_summary_entity.dart';
import '../../domain/entities/shipping_address_entity.dart';

enum EmptyCartContext { wishlist, popular }

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final CartSummaryEntity summary;
  final EmptyCartContext emptyContext;

  const CartLoaded({
    required this.summary,
    this.emptyContext = EmptyCartContext.wishlist,
  });

  List<CartItemEntity> get items => summary.items;
  List<CartItemEntity> get wishlistSuggestions => summary.wishlistSuggestions;
  List<ShopProductEntity> get popularSuggestions => summary.popularSuggestions;
  ShippingAddressEntity? get shippingAddress => summary.shippingAddress;
  double get subtotal => summary.subtotal;
  int get itemCount => summary.itemCount;
  bool get isEmpty => summary.isEmpty;

  CartLoaded copyWith({
    CartSummaryEntity? summary,
    EmptyCartContext? emptyContext,
  }) {
    return CartLoaded(
      summary: summary ?? this.summary,
      emptyContext: emptyContext ?? this.emptyContext,
    );
  }

  @override
  List<Object?> get props => [summary, emptyContext];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
