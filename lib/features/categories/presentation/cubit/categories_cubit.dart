import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/gender_filter.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesCubit({required this.getCategoriesUseCase})
      : super(const CategoriesInitial());

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
}
