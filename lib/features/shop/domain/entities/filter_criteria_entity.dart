import 'package:equatable/equatable.dart';

enum ShopSortOption { popular, newest, priceHighToLow }

class FilterCriteriaEntity extends Equatable {
  final List<String> selectedSubCategories;
  final String sizeType;
  final String? selectedSize;
  final String? selectedColor;
  final double minPrice;
  final double maxPrice;
  final ShopSortOption sortOption;

  const FilterCriteriaEntity({
    this.selectedSubCategories = const [],
    this.sizeType = 'Clothes',
    this.selectedSize,
    this.selectedColor,
    this.minPrice = 10.0,
    this.maxPrice = 150.0,
    this.sortOption = ShopSortOption.popular,
  });

  FilterCriteriaEntity copyWith({
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
    return FilterCriteriaEntity(
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
