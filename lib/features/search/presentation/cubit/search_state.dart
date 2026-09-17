import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/search_data_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final SearchDataEntity data;

  const SearchLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class SearchResultsLoading extends SearchState {
  final String query;

  const SearchResultsLoading({required this.query});

  @override
  List<Object?> get props => [query];
}

class SearchResultsLoaded extends SearchState {
  final String query;
  final List<ShopProductEntity> results;
  final FilterCriteriaEntity? appliedFilter;

  const SearchResultsLoaded({
    required this.query,
    required this.results,
    this.appliedFilter,
  });

  @override
  List<Object?> get props => [query, results, appliedFilter];
}

class SearchError extends SearchState {
  final Failure failure;

  const SearchError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
