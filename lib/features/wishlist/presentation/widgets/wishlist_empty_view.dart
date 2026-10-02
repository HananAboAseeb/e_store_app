import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/domain/entities/home_data_entity.dart';
import '../../../home/presentation/widgets/most_popular_section.dart';

class WishlistEmptyView extends StatelessWidget {
  final List<HomeProductEntity> popularProducts;

  const WishlistEmptyView({
    super.key,
    required this.popularProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Vertically centered empty state in the space above Most Popular
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceOption,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      size: 40.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Your Wishlist is Empty',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Most Popular anchored at the bottom
        if (popularProducts.isNotEmpty) ...[
          MostPopularSection(
            products: popularProducts,
            onSeeAllTap: () => context.go(RouteNames.kCatalogPage),
            onProductTap: (product) => context.push('/product/${product.id}'),
          ),
          SizedBox(height: 16.h),
        ],
      ],
    );
  }
}
