import 'package:flutter/material.dart';

import '../../../home/domain/entities/home_data_entity.dart';
import '../../../home/presentation/widgets/most_popular_section.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';

class ProductMostPopularCarousel extends StatelessWidget {
  final List<ShopProductEntity> products;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<ShopProductEntity> onProductTap;

  const ProductMostPopularCarousel({
    super.key,
    required this.products,
    this.onSeeAllTap,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    final tags = ['New', 'Sale', 'Hot', 'New', 'Sale'];
    final homeProducts = List.generate(products.length, (index) {
      final product = products[index];
      return HomeProductEntity(
        id: product.id,
        title: product.title,
        price: product.price,
        imageUrl: 'assets/images/popular_product_1.png',
        likeCount: 1780,
        tag: tags[index % tags.length],
      );
    });

    return MostPopularSection(
      title: 'Most Popular',
      products: homeProducts,
      onSeeAllTap: onSeeAllTap,
      onProductTap: (item) {
        final orig = products.firstWhere((p) => p.id == item.id);
        onProductTap(orig);
      },
    );
  }
}
