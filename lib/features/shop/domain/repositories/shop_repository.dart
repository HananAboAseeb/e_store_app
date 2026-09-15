import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/filter_criteria_entity.dart';
import '../entities/shop_category_entity.dart';
import '../entities/shop_product_entity.dart';

abstract class ShopRepository {
  Future<Either<Failure, List<ShopProductEntity>>> getProducts({
    FilterCriteriaEntity? criteria,
  });

  Future<Either<Failure, List<ShopCategoryEntity>>> getCategories();
}
