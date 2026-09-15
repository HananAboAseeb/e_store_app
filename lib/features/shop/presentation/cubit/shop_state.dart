import 'package:equatable/equatable.dart';

import '../../domain/entities/filter_criteria_entity.dart';
import '../../domain/entities/shop_category_entity.dart';
import '../../domain/entities/shop_product_entity.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object?> get props => [];
}

class ShopInitial extends ShopState {
  const ShopInitial();
}

class ShopLoading extends ShopState {
  const ShopLoading();
}

class ShopLoaded extends ShopState {
  final List<ShopProductEntity> products;
  final List<ShopCategoryEntity> categories;
  final String? selectedSubCategory;
  final FilterCriteriaEntity filterCriteria;

  const ShopLoaded({
    required this.products,
    required this.categories,
    this.selectedSubCategory,
    this.filterCriteria = const FilterCriteriaEntity(),
  });

  bool get isFilterActive =>
      filterCriteria.selectedSubCategories.isNotEmpty ||
      filterCriteria.selectedSize != null ||
      filterCriteria.selectedColor != null ||
      filterCriteria.minPrice > 10.0 ||
      filterCriteria.maxPrice < 150.0 ||
      filterCriteria.sortOption != ShopSortOption.popular;

  ShopLoaded copyWith({
    List<ShopProductEntity>? products,
    List<ShopCategoryEntity>? categories,
    String? selectedSubCategory,
    bool clearSubCategory = false,
    FilterCriteriaEntity? filterCriteria,
  }) {
    return ShopLoaded(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedSubCategory: clearSubCategory
          ? null
          : (selectedSubCategory ?? this.selectedSubCategory),
      filterCriteria: filterCriteria ?? this.filterCriteria,
    );
  }

  @override
  List<Object?> get props => [
        products,
        categories,
        selectedSubCategory,
        filterCriteria,
      ];
}

class ShopError extends ShopState {
  final String message;

  const ShopError({required this.message});

  @override
  List<Object?> get props => [message];
}
