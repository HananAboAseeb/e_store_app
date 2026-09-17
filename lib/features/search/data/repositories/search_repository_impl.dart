import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/image_search_result_entity.dart';
import '../../domain/entities/search_data_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_mock_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchMockDataSource mockDataSource;

  SearchRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, SearchDataEntity>> getSearchData() async {
    return await safeCall(() async {
      final history = await mockDataSource.getSearchHistory();
      final recommendations = await mockDataSource.getRecommendations();
      final discover = await mockDataSource.getDiscoverProducts();
      return SearchDataEntity(
        history: history,
        recommendations: recommendations,
        discoverProducts: discover,
      );
    });
  }

  @override
  Future<Either<Failure, List<ShopProductEntity>>> searchByText(
    String query, {
    FilterCriteriaEntity? filter,
  }) async {
    return await safeCall(
      () => mockDataSource.searchByText(query, filter: filter),
    );
  }

  @override
  Future<Either<Failure, ImageSearchResultEntity>> searchByImage(
    String imagePath,
  ) async {
    return await safeCall(
      () => mockDataSource.searchByImage(imagePath),
    );
  }

  @override
  Future<Either<Failure, Unit>> clearSearchHistory() async {
    return await safeCall(() async {
      await mockDataSource.clearSearchHistory();
      return unit;
    });
  }
}
