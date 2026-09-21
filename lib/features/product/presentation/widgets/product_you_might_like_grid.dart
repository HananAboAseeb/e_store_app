import 'package:flutter/material.dart';

import '../../../home/domain/entities/home_data_entity.dart';
import '../../../home/presentation/widgets/stuff_for_you_section.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';

class ProductYouMightLikeGrid extends StatelessWidget {
  final List<ShopProductEntity> products;
  final ValueChanged<ShopProductEntity> onProductTap;

  const ProductYouMightLikeGrid({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    final homeProducts = products.map((product) {
      final discount = product.isDiscounted && product.originalPrice != null
          ? (((product.originalPrice! - product.price) /
                      product.originalPrice!) *
                  100)
              .round()
          : null;

      return HomeProductEntity(
        id: product.id,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        discountPercentage: discount,
      );
    }).toList();

    return StuffForYouSection(
      title: 'You Might Like',
      products: homeProducts,
      onProductTap: (item) {
        final orig = products.firstWhere((p) => p.id == item.id);
        onProductTap(orig);
      },
    );
  }
}
