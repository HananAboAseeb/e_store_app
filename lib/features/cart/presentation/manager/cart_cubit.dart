import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/remove_wishlist_suggestion_usecase.dart';
import '../../domain/usecases/update_cart_quantity_usecase.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final RemoveWishlistSuggestionUseCase removeWishlistSuggestionUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.removeWishlistSuggestionUseCase,
    required this.clearCartUseCase,
  }) : super(const CartInitial());

  EmptyCartContext _emptyContext = EmptyCartContext.wishlist;

  Future<void> loadCart() async {
    emit(const CartLoading());
    final result = await getCartUseCase();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (summary) {
        // If wishlist is empty, default empty context to popular
        if (summary.wishlistSuggestions.isEmpty) {
          _emptyContext = EmptyCartContext.popular;
        }
        emit(CartLoaded(
          summary: summary,
          emptyContext: _emptyContext,
        ));
      },
    );
  }

  Future<void> incrementQuantity(String itemId) async {
    if (state is! CartLoaded) return;
    final currentLoaded = state as CartLoaded;
    final item = currentLoaded.items.firstWhere(
      (e) => e.id == itemId,
      orElse: () => const CartItemEntity(
        id: '',
        productId: '',
        title: '',
        imageUrl: '',
        unitPrice: 0,
      ),
    );

    if (item.id.isEmpty) return;

    final result = await updateCartQuantityUseCase(
      UpdateCartQuantityParams(itemId: itemId, quantity: item.quantity + 1),
    );

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (summary) => emit(currentLoaded.copyWith(summary: summary)),
    );
  }

  Future<void> decrementQuantity(String itemId) async {
    if (state is! CartLoaded) return;
    final currentLoaded = state as CartLoaded;
    final item = currentLoaded.items.firstWhere(
      (e) => e.id == itemId,
      orElse: () => const CartItemEntity(
        id: '',
        productId: '',
        title: '',
        imageUrl: '',
        unitPrice: 0,
      ),
    );

    if (item.id.isEmpty) return;
    if (item.quantity <= 1) {
      // Minimum quantity boundary: 1
      return;
    }

    final result = await updateCartQuantityUseCase(
      UpdateCartQuantityParams(itemId: itemId, quantity: item.quantity - 1),
    );

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (summary) => emit(currentLoaded.copyWith(summary: summary)),
    );
  }

  Future<void> removeItem(String itemId) async {
    if (state is! CartLoaded) return;
    final currentLoaded = state as CartLoaded;

    final result = await removeFromCartUseCase(itemId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (summary) => emit(currentLoaded.copyWith(summary: summary)),
    );
  }

  Future<void> addCartItem(CartItemEntity item) async {
    if (state is! CartLoaded) return;
    final currentLoaded = state as CartLoaded;

    final result = await addToCartUseCase(item);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (summary) => emit(currentLoaded.copyWith(summary: summary)),
    );
  }

  Future<void> addProductToCart(
    ShopProductEntity product, {
    String size = 'M',
    String color = 'Pink',
  }) async {
    if (state is! CartLoaded) return;
    final currentLoaded = state as CartLoaded;

    final item = CartItemEntity(
      id: 'cart-item-${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      title: product.title,
      imageUrl: product.imageUrl,
      size: size,
      color: color,
      quantity: 1,
      unitPrice: product.price,
    );

    final result = await addToCartUseCase(item);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (summary) => emit(currentLoaded.copyWith(summary: summary)),
    );
  }

  Future<void> removeFromWishlist(String itemId) async {
    if (state is! CartLoaded) return;
    final currentLoaded = state as CartLoaded;

    final result = await removeWishlistSuggestionUseCase(itemId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (summary) {
        var context = currentLoaded.emptyContext;
        if (summary.wishlistSuggestions.isEmpty) {
          context = EmptyCartContext.popular;
          _emptyContext = EmptyCartContext.popular;
        }
        emit(currentLoaded.copyWith(
          summary: summary,
          emptyContext: context,
        ));
      },
    );
  }

  Future<void> clearCart() async {
    if (state is! CartLoaded) return;
    final currentLoaded = state as CartLoaded;

    final result = await clearCartUseCase();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (summary) => emit(currentLoaded.copyWith(summary: summary)),
    );
  }

  void setEmptyCartContext(EmptyCartContext context) {
    _emptyContext = context;
    if (state is CartLoaded) {
      emit((state as CartLoaded).copyWith(emptyContext: context));
    }
  }
}
