import 'package:equatable/equatable.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';
import 'recommendation_entity.dart';
import 'search_history_entity.dart';

class SearchDataEntity extends Equatable {
  final List<SearchHistoryEntity> history;
  final List<RecommendationEntity> recommendations;
  final List<ShopProductEntity> discoverProducts;

  const SearchDataEntity({
    required this.history,
    required this.recommendations,
    required this.discoverProducts,
  });

  SearchDataEntity copyWith({
    List<SearchHistoryEntity>? history,
    List<RecommendationEntity>? recommendations,
    List<ShopProductEntity>? discoverProducts,
  }) {
    return SearchDataEntity(
      history: history ?? this.history,
      recommendations: recommendations ?? this.recommendations,
      discoverProducts: discoverProducts ?? this.discoverProducts,
    );
  }

  @override
  List<Object?> get props => [history, recommendations, discoverProducts];
}
