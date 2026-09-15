import 'package:equatable/equatable.dart';

import '../../domain/entities/filter_criteria_entity.dart';

class FilterState extends Equatable {
  final List<String> selectedSubCategories;
  final String sizeType;
  final String? selectedSize;
  final String? selectedColor;
  final double minPrice;
  final double maxPrice;
  final ShopSortOption sortOption;

  const FilterState({
    this.selectedSubCategories = const [],
    this.sizeType = 'Clothes',
    this.selectedSize,
    this.selectedColor,
    this.minPrice = 10.0,
    this.maxPrice = 150.0,
    this.sortOption = ShopSortOption.popular,
  });

  factory FilterState.fromCriteria(FilterCriteriaEntity criteria) {
    return FilterState(
      selectedSubCategories: List.from(criteria.selectedSubCategories),
      sizeType: criteria.sizeType,
      selectedSize: criteria.selectedSize,
      selectedColor: criteria.selectedColor,
      minPrice: criteria.minPrice,
      maxPrice: criteria.maxPrice,
      sortOption: criteria.sortOption,
    );
  }

  FilterCriteriaEntity toCriteria() {
    return FilterCriteriaEntity(
      selectedSubCategories: selectedSubCategories,
      sizeType: sizeType,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sortOption: sortOption,
    );
  }

  FilterState copyWith({
    List<String>? selectedSubCategories,
    String? sizeType,
    String? selectedSize,
    bool clearSize = false,
    String? selectedColor,
    bool clearColor = false,
    double? minPrice,
    double? maxPrice,
    ShopSortOption? sortOption,
  }) {
    return FilterState(
      selectedSubCategories:
          selectedSubCategories ?? this.selectedSubCategories,
      sizeType: sizeType ?? this.sizeType,
      selectedSize: clearSize ? null : (selectedSize ?? this.selectedSize),
      selectedColor: clearColor ? null : (selectedColor ?? this.selectedColor),
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  @override
  List<Object?> get props => [
        selectedSubCategories,
        sizeType,
        selectedSize,
        selectedColor,
        minPrice,
        maxPrice,
        sortOption,
      ];
}
