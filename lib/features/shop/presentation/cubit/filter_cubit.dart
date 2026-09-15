import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/filter_criteria_entity.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit([FilterCriteriaEntity? initialCriteria])
      : super(
          initialCriteria != null
              ? FilterState.fromCriteria(initialCriteria)
              : const FilterState(),
        );

  void toggleCategory(String categoryName) {
    final currentList = List<String>.from(state.selectedSubCategories);
    final exists = currentList.any(
      (c) => c.toLowerCase() == categoryName.toLowerCase(),
    );

    if (exists) {
      currentList.removeWhere(
        (c) => c.toLowerCase() == categoryName.toLowerCase(),
      );
    } else {
      currentList.add(categoryName);
    }

    emit(state.copyWith(selectedSubCategories: currentList));
  }

  void setSizeType(String type) {
    emit(state.copyWith(sizeType: type));
  }

  void selectSize(String? size) {
    if (state.selectedSize == size) {
      emit(state.copyWith(clearSize: true));
    } else {
      emit(state.copyWith(selectedSize: size));
    }
  }

  void selectColor(String? color) {
    if (state.selectedColor == color) {
      emit(state.copyWith(clearColor: true));
    } else {
      emit(state.copyWith(selectedColor: color));
    }
  }

  void updatePriceRange(double min, double max) {
    emit(state.copyWith(minPrice: min, maxPrice: max));
  }

  void setSortOption(ShopSortOption option) {
    emit(state.copyWith(sortOption: option));
  }

  void clearAll() {
    emit(const FilterState());
  }
}
