import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../entities/category_group_entity.dart';
import '../entities/gender_filter.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryGroupEntity>>> getCategories({
    GenderFilter gender = GenderFilter.all,
  });

  Future<Either<Failure, List<ShopProductEntity>>> getJustForYouProducts();
}
