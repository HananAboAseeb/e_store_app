import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/shop_category_entity.dart';
import '../repositories/shop_repository.dart';

class GetShopCategoriesUseCase
    extends UseCase<List<ShopCategoryEntity>, NoParam> {
  final ShopRepository repository;

  GetShopCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopCategoryEntity>>> call([
    NoParam? param,
  ]) {
    return repository.getCategories();
  }
}
