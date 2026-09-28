import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/use_cases/use_case.dart';
import '../../domain/entities/gender_filter.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_just_for_you_products_usecase.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetJustForYouProductsUseCase getJustForYouProductsUseCase;

  CategoriesCubit({
    required this.getCategoriesUseCase,
    required this.getJustForYouProductsUseCase,
  }) : super(const CategoriesInitial());

  Future<void> loadCategories({
    GenderFilter gender = GenderFilter.all,
  }) async {
    emit(const CategoriesLoading());

    final result = await getCategoriesUseCase(gender);

    result.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (groups) => emit(CategoriesLoaded(
        groups: groups,
        activeGender: gender,
        expandedGroupId: 'clothing',
      )),
    );
  }

  void selectGender(GenderFilter gender) {
    loadCategories(gender: gender);
  }

  void toggleCategoryExpansion(String groupId) {
    final currentState = state;
    if (currentState is CategoriesLoaded) {
      final newExpandedId =
          currentState.expandedGroupId == groupId ? null : groupId;
      emit(currentState.copyWith(
        expandedGroupId: newExpandedId,
        clearExpandedGroupId: newExpandedId == null,
      ));
    }
  }

  Future<void> loadJustForYouProducts() async {
    emit(const JustForYouLoading());

    final result = await getJustForYouProductsUseCase(NoParam());

    result.fold(
      (failure) => emit(JustForYouError(message: failure.message)),
      (products) => emit(JustForYouLoaded(products: products)),
    );
  }
}
