import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/shop_product_entity.dart';

class ShopProductCard extends StatelessWidget {
  final ShopProductEntity product;
  final VoidCallback? onTap;

  const ShopProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container with full white border frame and subtle shadow (Figma)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 12.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              padding: EdgeInsets.all(AppSpacing.xs),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9.r),
                child: Container(
                  color: AppColors.surfaceCardImage,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceCardImage,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 40.sp,
                          color: AppColors.gray400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // Product Title
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textCardTitle,
              height: 1.25,
            ),
          ),
          SizedBox(height: 4.h),
          // Price Row
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  _formatPrice(product.price),
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.black,
                  ),
                ),
                if (product.isDiscounted && product.originalPrice != null) ...[
                  SizedBox(width: 8.w),
                  Text(
                    _formatPrice(product.originalPrice!),
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.discount,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.discount,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}
