import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/home_data_entity.dart';
import 'home_section_header.dart';
import 'popular_product_card.dart';

/// Reusable Most Popular section across Home and Product Details screens.
class MostPopularSection extends StatelessWidget {
  final String title;
  final List<HomeProductEntity> products;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<HomeProductEntity>? onProductTap;

  const MostPopularSection({
    super.key,
    this.title = 'Most Popular',
    required this.products,
    this.onSeeAllTap,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionHeader(
          title: title,
          showSeeAll: true,
          onSeeAllTap: onSeeAllTap,
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 140.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final prod = products[index];
              return PopularProductCard(
                product: prod,
                onTap: () => onProductTap?.call(prod),
              );
            },
          ),
        ),
      ],
    );
  }
}
