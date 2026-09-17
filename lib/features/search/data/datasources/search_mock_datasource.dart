import '../../../shop/data/models/shop_product_model.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../models/image_search_result_model.dart';
import '../models/recommendation_model.dart';
import '../models/search_history_model.dart';

abstract class SearchMockDataSource {
  Future<List<SearchHistoryModel>> getSearchHistory();
  Future<List<RecommendationModel>> getRecommendations();
  Future<List<ShopProductModel>> getDiscoverProducts();
  Future<List<ShopProductModel>> searchByText(
    String query, {
    FilterCriteriaEntity? filter,
  });
  Future<ImageSearchResultModel> searchByImage(String imagePath);
  Future<void> clearSearchHistory();
}
