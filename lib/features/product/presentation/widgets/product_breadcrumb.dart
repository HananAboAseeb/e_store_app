import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ProductBreadcrumb extends StatelessWidget {
  final List<String> breadcrumb;
  final bool isWishlisted;
  final VoidCallback onWishlistTap;
  final VoidCallback onShareTap;
  final ValueChanged<String>? onCategoryTap;

  const ProductBreadcrumb({
    super.key,
    required this.breadcrumb,
    required this.isWishlisted,
    required this.onWishlistTap,
    required this.onShareTap,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Breadcrumb text
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (int i = 0; i < breadcrumb.length; i++) ...[
                  GestureDetector(
                    onTap: onCategoryTap != null
                        ? () => onCategoryTap!(breadcrumb[i])
                        : null,
                    child: Text(
                      breadcrumb[i],
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: i == breadcrumb.length - 1
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: i == breadcrumb.length - 1
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  if (i < breadcrumb.length - 1) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        '>',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.gray400,
                        ),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),

          // Action buttons: Heart (Wishlist) & Share
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onWishlistTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    size: 22.sp,
                    color: isWishlisted
                        ? const Color(0xFFFF3B30)
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onShareTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Icon(
                    Icons.share_outlined,
                    size: 22.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
