import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/use_cases/use_case.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../../domain/usecases/add_to_cart_from_wishlist_usecase.dart';
import '../../domain/usecases/get_wishlist_popular_products_usecase.dart';
import '../../domain/usecases/get_wishlist_usecase.dart';
import '../../domain/usecases/remove_from_wishlist_usecase.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlistUseCase getWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;
  final AddToCartFromWishlistUseCase addToCartFromWishlistUseCase;
  final GetWishlistPopularProductsUseCase getWishlistPopularProductsUseCase;

  WishlistCubit({
    required this.getWishlistUseCase,
    required this.removeFromWishlistUseCase,
    required this.addToCartFromWishlistUseCase,
    required this.getWishlistPopularProductsUseCase,
  }) : super(const WishlistInitial());

  Future<void> loadWishlist() async {
    emit(const WishlistLoading());
    final result = await getWishlistUseCase(NoParam());
    await result.fold(
      (failure) async {
        emit(WishlistError(failure.message));
      },
      (items) async {
        if (items.isEmpty) {
          await _emitEmptyState();
        } else {
          emit(WishlistLoaded(items: items));
        }
      },
    );
  }

  Future<void> removeItem(String itemId) async {
    if (state is WishlistLoaded) {
      final currentItems = (state as WishlistLoaded).items;
      final updatedList = currentItems.where((i) => i.id != itemId).toList();

      if (updatedList.isEmpty) {
        await _emitEmptyState();
      } else {
        emit(WishlistLoaded(items: updatedList));
      }

      final result = await removeFromWishlistUseCase(itemId);
      result.fold(
        (failure) {
          // If removal fails, reload original list
          emit(WishlistLoaded(items: currentItems, message: failure.message));
        },
        (_) {
          // Successfully removed
        },
      );
    }
  }

  Future<void> addToCart(WishlistItemEntity item) async {
    final result = await addToCartFromWishlistUseCase(item);
    result.fold(
      (failure) {
        if (state is WishlistLoaded) {
          emit((state as WishlistLoaded).copyWith(message: failure.message));
        }
      },
      (_) {
        if (state is WishlistLoaded) {
          emit(
            (state as WishlistLoaded).copyWith(
              message: '${item.title} added to cart',
            ),
          );
        }
      },
    );
  }

  void clearMessage() {
    if (state is WishlistLoaded) {
      emit((state as WishlistLoaded).copyWith(message: null));
    }
  }

  Future<void> _emitEmptyState() async {
    final popularResult = await getWishlistPopularProductsUseCase(
      NoParam(),
    );
    popularResult.fold(
      (failure) => emit(const WishlistEmpty(popularProducts: [])),
      (products) => emit(WishlistEmpty(popularProducts: products)),
    );
  }
}
