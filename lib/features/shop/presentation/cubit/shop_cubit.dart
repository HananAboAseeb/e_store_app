import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/filter_criteria_entity.dart';
import '../../domain/usecases/get_shop_categories_usecase.dart';
import '../../domain/usecases/get_shop_products_usecase.dart';
import 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final GetShopProductsUseCase getShopProductsUseCase;
  final GetShopCategoriesUseCase getShopCategoriesUseCase;

  ShopCubit({
    required this.getShopProductsUseCase,
    required this.getShopCategoriesUseCase,
  }) : super(const ShopInitial());

  Future<void> loadShopData() async {
    emit(const ShopLoading());

    final categoriesResult = await getShopCategoriesUseCase();
    final productsResult = await getShopProductsUseCase();

    categoriesResult.fold(
      (failure) => emit(ShopError(message: failure.message)),
      (categories) {
        productsResult.fold(
          (failure) => emit(ShopError(message: failure.message)),
          (products) {
            emit(ShopLoaded(
              products: products,
              categories: categories,
            ));
          },
        );
      },
    );
  }

  Future<void> selectSubCategory(String? subCategory) async {
    final currentState = state;
    if (currentState is! ShopLoaded) return;

    final isSame = currentState.selectedSubCategory == subCategory;
    final targetCategory = isSame ? null : subCategory;

    final updatedCriteria = currentState.filterCriteria.copyWith(
      selectedSubCategories: targetCategory != null ? [targetCategory] : [],
    );

    final productsResult = await getShopProductsUseCase(updatedCriteria);

    productsResult.fold(
      (failure) => emit(ShopError(message: failure.message)),
      (products) {
        emit(currentState.copyWith(
          products: products,
          selectedSubCategory: targetCategory,
          clearSubCategory: targetCategory == null,
          filterCriteria: updatedCriteria,
        ));
      },
    );
  }

  Future<void> applyFilter(FilterCriteriaEntity criteria) async {
    final currentState = state;
    if (currentState is! ShopLoaded) return;

    final productsResult = await getShopProductsUseCase(criteria);

    productsResult.fold(
      (failure) => emit(ShopError(message: failure.message)),
      (products) {
        final activeSubCategory = criteria.selectedSubCategories.isNotEmpty
            ? criteria.selectedSubCategories.first
            : null;

        emit(currentState.copyWith(
          products: products,
          selectedSubCategory: activeSubCategory,
          clearSubCategory: activeSubCategory == null,
          filterCriteria: criteria,
        ));
      },
    );
  }

  Future<void> clearFilter() async {
    final currentState = state;
    if (currentState is! ShopLoaded) return;

    const defaultCriteria = FilterCriteriaEntity();
    final productsResult = await getShopProductsUseCase(defaultCriteria);

    productsResult.fold(
      (failure) => emit(ShopError(message: failure.message)),
      (products) {
        emit(currentState.copyWith(
          products: products,
          clearSubCategory: true,
          filterCriteria: defaultCriteria,
        ));
      },
    );
  }
}
