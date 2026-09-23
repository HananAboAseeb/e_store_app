import 'package:flutter_clean_architecture_template/features/cart/data/datasources/cart_mock_data_source_impl.dart';
import 'package:flutter_clean_architecture_template/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:flutter_clean_architecture_template/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flutter_clean_architecture_template/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:flutter_clean_architecture_template/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:flutter_clean_architecture_template/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_clean_architecture_template/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:flutter_clean_architecture_template/features/cart/domain/usecases/remove_wishlist_suggestion_usecase.dart';
import 'package:flutter_clean_architecture_template/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/manager/cart_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CartMockDataSourceImpl mockDataSource;
  late CartRepositoryImpl repository;
  late GetCartUseCase getCartUseCase;
  late AddToCartUseCase addToCartUseCase;
  late RemoveFromCartUseCase removeFromCartUseCase;
  late UpdateCartQuantityUseCase updateCartQuantityUseCase;
  late RemoveWishlistSuggestionUseCase removeWishlistSuggestionUseCase;
  late ClearCartUseCase clearCartUseCase;

  setUp(() {
    mockDataSource = CartMockDataSourceImpl();
    repository = CartRepositoryImpl(mockDataSource);
    getCartUseCase = GetCartUseCase(repository);
    addToCartUseCase = AddToCartUseCase(repository);
    removeFromCartUseCase = RemoveFromCartUseCase(repository);
    updateCartQuantityUseCase = UpdateCartQuantityUseCase(repository);
    removeWishlistSuggestionUseCase =
        RemoveWishlistSuggestionUseCase(repository);
    clearCartUseCase = ClearCartUseCase(repository);
  });

  CartCubit buildCubit() {
    return CartCubit(
      getCartUseCase: getCartUseCase,
      addToCartUseCase: addToCartUseCase,
      removeFromCartUseCase: removeFromCartUseCase,
      updateCartQuantityUseCase: updateCartQuantityUseCase,
      removeWishlistSuggestionUseCase: removeWishlistSuggestionUseCase,
      clearCartUseCase: clearCartUseCase,
    );
  }

  test('initial state should be CartInitial', () {
    final cubit = buildCubit();
    expect(cubit.state, const CartInitial());
    cubit.close();
  });

  test('loadCart loads initial cart items and subtotal', () async {
    final cubit = buildCubit();
    expectLater(
      cubit.stream,
      emitsInOrder([
        const CartLoading(),
        isA<CartLoaded>()
            .having((s) => s.items.length, 'items length', 2)
            .having((s) => s.subtotal, 'subtotal', 34.00)
            .having((s) => s.itemCount, 'itemCount', 2),
      ]),
    );
    await cubit.loadCart();
    cubit.close();
  });

  test('incrementQuantity increases quantity and subtotal', () async {
    final cubit = buildCubit();
    await cubit.loadCart();
    await cubit.incrementQuantity('cart-item-1');

    final state = cubit.state as CartLoaded;
    expect(state.items.firstWhere((e) => e.id == 'cart-item-1').quantity, 2);
    expect(state.subtotal, 51.00);
    cubit.close();
  });

  test('decrementQuantity respects minimum quantity of 1', () async {
    final cubit = buildCubit();
    await cubit.loadCart();
    await cubit.decrementQuantity('cart-item-1');

    final state = cubit.state as CartLoaded;
    expect(state.items.firstWhere((e) => e.id == 'cart-item-1').quantity, 1);
    expect(state.subtotal, 34.00);
    cubit.close();
  });

  test('removeItem removes item and decreases item count', () async {
    final cubit = buildCubit();
    await cubit.loadCart();
    await cubit.removeItem('cart-item-1');

    final state = cubit.state as CartLoaded;
    expect(state.items.length, 1);
    expect(state.subtotal, 17.00);
    cubit.close();
  });

  test('clearCart empties the cart', () async {
    final cubit = buildCubit();
    await cubit.loadCart();
    await cubit.clearCart();

    final state = cubit.state as CartLoaded;
    expect(state.isEmpty, true);
    expect(state.subtotal, 0.0);
    cubit.close();
  });

  test('addCartItem adds item to cart', () async {
    final cubit = buildCubit();
    await cubit.loadCart();
    await cubit.addCartItem(const CartItemEntity(
      id: 'new-item',
      productId: 'new-prod',
      title: 'New Product',
      imageUrl: 'assets/images/cat_bag_1.png',
      unitPrice: 20.00,
    ));

    final state = cubit.state as CartLoaded;
    expect(state.items.length, 3);
    expect(state.subtotal, 54.00);
    cubit.close();
  });
}
