import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../entities/image_search_result_entity.dart';
import '../entities/search_data_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchDataEntity>> getSearchData();
  Future<Either<Failure, List<ShopProductEntity>>> searchByText(
    String query, {
    FilterCriteriaEntity? filter,
  });
  Future<Either<Failure, ImageSearchResultEntity>> searchByImage(
    String imagePath,
  );
  Future<Either<Failure, Unit>> clearSearchHistory();
}
