import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/category_group_entity.dart';
import '../../domain/entities/gender_filter.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_mock_datasource.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesMockDataSource mockDataSource;

  CategoriesRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, List<CategoryGroupEntity>>> getCategories({
    GenderFilter gender = GenderFilter.all,
  }) async {
    return await safeCall(
      () => mockDataSource.getCategories(gender: gender),
    );
  }

  @override
  Future<Either<Failure, List<ShopProductEntity>>>
      getJustForYouProducts() async {
    return await safeCall(
      () => mockDataSource.getJustForYouProducts(),
    );
  }
}
