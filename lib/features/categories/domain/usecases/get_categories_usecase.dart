import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/category_group_entity.dart';
import '../entities/gender_filter.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUseCase
    extends UseCase<List<CategoryGroupEntity>, GenderFilter> {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryGroupEntity>>> call([
    GenderFilter? param,
  ]) {
    return repository.getCategories(gender: param ?? GenderFilter.all);
  }
}
