import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../../domain/entities/flash_sale_product_entity.dart';
import '../../domain/usecases/get_flash_sale_data_usecase.dart';
import 'flash_sale_state.dart';

class FlashSaleCubit extends Cubit<FlashSaleState> {
  final GetFlashSaleDataUseCase getFlashSaleDataUseCase;

  FlashSaleCubit({required this.getFlashSaleDataUseCase})
      : super(const FlashSaleInitial());

  Future<void> loadFlashSaleData({int? defaultDiscount = 20}) async {
    emit(const FlashSaleLoading());

    final result = await getFlashSaleDataUseCase(NoParam());

    result.fold(
      (failure) => emit(FlashSaleError(failure.message)),
      (data) {
        List<FlashSaleProductEntity> filtered;
        if (defaultDiscount == null) {
          filtered = data.products;
        } else {
          filtered = data.products
              .where((p) => p.discountPercentage == defaultDiscount)
              .toList();
        }

        emit(FlashSaleLoaded(
          allProducts: data.products,
          filteredProducts: filtered,
          selectedDiscount: defaultDiscount,
          liveStream: data.liveStream,
          popularProducts: data.popularProducts,
          countdownDuration: data.countdownDuration,
        ));
      },
    );
  }

  void selectDiscountFilter(int? discountPercentage) {
    final currentState = state;
    if (currentState is FlashSaleLoaded) {
      List<FlashSaleProductEntity> filtered;
      if (discountPercentage == null) {
        filtered = currentState.allProducts;
      } else {
        filtered = currentState.allProducts
            .where((p) => p.discountPercentage == discountPercentage)
            .toList();
      }

      emit(currentState.copyWith(
        selectedDiscount: discountPercentage,
        clearDiscount: discountPercentage == null,
        filteredProducts: filtered,
      ));
    }
  }

  Future<void> refresh() async {
    final currentSelectedDiscount = (state is FlashSaleLoaded)
        ? (state as FlashSaleLoaded).selectedDiscount
        : 20;

    await loadFlashSaleData(defaultDiscount: currentSelectedDiscount);
  }
}
