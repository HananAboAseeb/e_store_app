import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../repositories/search_repository.dart';

class SearchByTextParams {
  final String query;
  final FilterCriteriaEntity? filter;

  SearchByTextParams({
    required this.query,
    this.filter,
  });
}

class SearchByTextUseCase
    implements UseCase<List<ShopProductEntity>, SearchByTextParams> {
  final SearchRepository repository;

  SearchByTextUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopProductEntity>>> call([
    SearchByTextParams? param,
  ]) {
    final query = param?.query ?? '';
    final filter = param?.filter;
    return repository.searchByText(query, filter: filter);
  }
}
