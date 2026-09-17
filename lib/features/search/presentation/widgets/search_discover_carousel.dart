import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../../shop/presentation/widgets/shop_product_card.dart';

class SearchDiscoverCarousel extends StatelessWidget {
  final List<ShopProductEntity> products;
  final ValueChanged<ShopProductEntity> onProductTap;

  const SearchDiscoverCarousel({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final product = products[index];
              return SizedBox(
                width: 140.w,
                child: ShopProductCard(
                  product: product,
                  onTap: () => onProductTap(product),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
