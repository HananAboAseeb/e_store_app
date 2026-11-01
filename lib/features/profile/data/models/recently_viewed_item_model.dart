import '../../../shop/data/models/shop_product_model.dart';
import '../../domain/entities/recently_viewed_item_entity.dart';

class RecentlyViewedItemModel extends RecentlyViewedItemEntity {
  const RecentlyViewedItemModel({
    required super.id,
    required super.product,
    required super.viewedAt,
  });

  factory RecentlyViewedItemModel.fromJson(Map<String, dynamic> json) {
    return RecentlyViewedItemModel(
      id: json['id'] as String,
      product:
          ShopProductModel.fromJson(json['product'] as Map<String, dynamic>),
      viewedAt: DateTime.parse(json['viewedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': (product as ShopProductModel).toJson(),
      'viewedAt': viewedAt.toIso8601String(),
    };
  }

  factory RecentlyViewedItemModel.fromEntity(RecentlyViewedItemEntity entity) {
    return RecentlyViewedItemModel(
      id: entity.id,
      product: entity.product,
      viewedAt: entity.viewedAt,
    );
  }
}
