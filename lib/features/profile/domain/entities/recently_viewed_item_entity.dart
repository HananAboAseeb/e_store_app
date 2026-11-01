import 'package:equatable/equatable.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';

class RecentlyViewedItemEntity extends Equatable {
  final String id;
  final ShopProductEntity product;
  final DateTime viewedAt;

  const RecentlyViewedItemEntity({
    required this.id,
    required this.product,
    required this.viewedAt,
  });

  @override
  List<Object?> get props => [id, product, viewedAt];
}
