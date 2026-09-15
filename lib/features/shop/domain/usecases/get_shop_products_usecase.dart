import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/filter_criteria_entity.dart';
import '../entities/shop_product_entity.dart';
import '../repositories/shop_repository.dart';

class GetShopProductsUseCase
    extends UseCase<List<ShopProductEntity>, FilterCriteriaEntity?> {
  final ShopRepository repository;

  GetShopProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopProductEntity>>> call([
    FilterCriteriaEntity? param,
  ]) {
    return repository.getProducts(criteria: param);
  }
}
