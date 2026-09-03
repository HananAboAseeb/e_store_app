import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/home_data_entity.dart';
import 'home_section_header.dart';
import 'product_card_standard.dart';

class NewItemsSection extends StatelessWidget {
  final List<HomeProductEntity> products;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<HomeProductEntity>? onProductTap;

  const NewItemsSection({
    super.key,
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
          title: 'New Items',
          showSeeAll: true,
          onSeeAllTap: onSeeAllTap,
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 228.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCardStandard(
                product: product,
                width: 140.w,
                imageHeight: 140.h,
                showNewBadge: true,
                onTap: () => onProductTap?.call(product),
              );
            },
          ),
        ),
      ],
    );
  }
}
