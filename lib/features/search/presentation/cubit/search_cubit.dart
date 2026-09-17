import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/use_cases/use_case.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../../domain/entities/search_data_entity.dart';
import '../../domain/usecases/clear_search_history_usecase.dart';
import '../../domain/usecases/get_search_data_usecase.dart';
import '../../domain/usecases/search_by_text_usecase.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetSearchDataUseCase getSearchDataUseCase;
  final SearchByTextUseCase searchByTextUseCase;
  final ClearSearchHistoryUseCase clearSearchHistoryUseCase;

  SearchDataEntity? _cachedSearchData;
  String _currentQuery = '';
  FilterCriteriaEntity? _currentFilter;

  SearchCubit({
    required this.getSearchDataUseCase,
    required this.searchByTextUseCase,
    required this.clearSearchHistoryUseCase,
  }) : super(const SearchInitial());

  SearchDataEntity? get cachedSearchData => _cachedSearchData;
  String get currentQuery => _currentQuery;
  FilterCriteriaEntity? get currentFilter => _currentFilter;

  Future<void> loadSearchData() async {
    emit(const SearchLoading());
    final result = await getSearchDataUseCase(NoParam());
    result.fold(
      (failure) => emit(SearchError(failure: failure)),
      (data) {
        _cachedSearchData = data;
        emit(SearchLoaded(data: data));
      },
    );
  }

  Future<void> submitQuery(String query, {FilterCriteriaEntity? filter}) async {
    _currentQuery = query;
    _currentFilter = filter;
    emit(SearchResultsLoading(query: query));

    final result = await searchByTextUseCase(
      SearchByTextParams(query: query, filter: filter),
    );

    result.fold(
      (failure) => emit(SearchError(failure: failure)),
      (products) => emit(
        SearchResultsLoaded(
          query: query,
          results: products,
          appliedFilter: filter,
        ),
      ),
    );
  }

  Future<void> applyFilter(FilterCriteriaEntity filter) async {
    _currentFilter = filter;
    await submitQuery(_currentQuery, filter: filter);
  }

  Future<void> clearHistory() async {
    final result = await clearSearchHistoryUseCase(NoParam());
    result.fold(
      (failure) => emit(SearchError(failure: failure)),
      (_) {
        if (_cachedSearchData != null) {
          _cachedSearchData = _cachedSearchData!.copyWith(history: []);
          emit(SearchLoaded(data: _cachedSearchData!));
        }
      },
    );
  }

  void clearQuery() {
    _currentQuery = '';
    _currentFilter = null;
    if (_cachedSearchData != null) {
      emit(SearchLoaded(data: _cachedSearchData!));
    } else {
      loadSearchData();
    }
  }
}
