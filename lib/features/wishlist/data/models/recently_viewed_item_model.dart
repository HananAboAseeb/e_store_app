import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/recently_viewed_item_entity.dart';

class RecentlyViewedItemModel extends RecentlyViewedItemEntity {
  const RecentlyViewedItemModel({
    required super.id,
    required super.product,
    required super.viewedAt,
  });

  factory RecentlyViewedItemModel.fromEntity(RecentlyViewedItemEntity entity) {
    return RecentlyViewedItemModel(
      id: entity.id,
      product: entity.product,
      viewedAt: entity.viewedAt,
    );
  }

  factory RecentlyViewedItemModel.create({
    required String id,
    required ShopProductEntity product,
    required DateTime viewedAt,
  }) {
    return RecentlyViewedItemModel(
      id: id,
      product: product,
      viewedAt: viewedAt,
    );
  }
}
