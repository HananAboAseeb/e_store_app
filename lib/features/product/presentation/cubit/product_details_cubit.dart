import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_product_details_usecase.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  StreamSubscription<int>? _timerSubscription;

  ProductDetailsCubit({
    required this.getProductDetailsUseCase,
  }) : super(const ProductDetailsInitial());

  Future<void> loadProduct(String id, {bool? forceSale}) async {
    emit(const ProductDetailsLoading());

    final result = await getProductDetailsUseCase(id);
    result.fold(
      (failure) => emit(ProductDetailsError(failure)),
      (product) {
        final isSale = forceSale ?? product.isFlashSale;
        final remaining = product.flashSaleRemainingSeconds;

        emit(ProductDetailsLoaded(
          product: product,
          selectedVariantIndex: 0,
          selectedSize: product.availableSizes.isNotEmpty
              ? product.availableSizes.firstWhere(
                  (s) => s == 'M',
                  orElse: () => product.availableSizes.first,
                )
              : 'M',
          isWishlisted: false,
          remainingSeconds: remaining,
          isFlashSaleActive: isSale && remaining > 0,
        ));

        if (isSale && remaining > 0) {
          _startFlashSaleTimer(remaining);
        }
      },
    );
  }

  void _startFlashSaleTimer(int initialSeconds) {
    _timerSubscription?.cancel();

    _timerSubscription =
        Stream.periodic(const Duration(seconds: 1), (i) => i + 1).listen((_) {
      final current = state;
      if (current is ProductDetailsLoaded) {
        final nextSeconds = current.remainingSeconds - 1;
        if (nextSeconds <= 0) {
          _timerSubscription?.cancel();
          _timerSubscription = null;
          emit(current.copyWith(
            remainingSeconds: 0,
            isFlashSaleActive: false,
          ));
        } else {
          emit(current.copyWith(remainingSeconds: nextSeconds));
        }
      }
    });
  }

  void selectColorVariant(int index) {
    final current = state;
    if (current is ProductDetailsLoaded &&
        index >= 0 &&
        index < current.product.variants.length) {
      emit(current.copyWith(selectedVariantIndex: index));
    }
  }

  void selectSize(String size) {
    final current = state;
    if (current is ProductDetailsLoaded) {
      emit(current.copyWith(selectedSize: size));
    }
  }

  void toggleWishlist() {
    final current = state;
    if (current is ProductDetailsLoaded) {
      emit(current.copyWith(isWishlisted: !current.isWishlisted));
    }
  }

  void addToBasket() {
    // In Phase 1 UI mock: can be observed or consumed by callers
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }
}
