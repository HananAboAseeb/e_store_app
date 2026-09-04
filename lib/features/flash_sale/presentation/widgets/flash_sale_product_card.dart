import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/flash_sale_product_entity.dart';

class FlashSaleProductCard extends StatelessWidget {
  final FlashSaleProductEntity product;
  final VoidCallback? onTap;

  const FlashSaleProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const grayBg = Color(0xFFE5E6EA);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Box with Gray Container, Darken Blend Mode, and Discount Pill Badge
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 125.h,
                  decoration: BoxDecoration(
                    color: grayBg,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: Image.asset(
                    product.imageUrl,
                    color: grayBg,
                    colorBlendMode: BlendMode.darken,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),

                // Top-Right Corner Pill Discount Badge (-20%)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF334B),
                          Color(0xFFFF6987),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF334B).withOpacity(0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      '-${product.discountPercentage}%',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // 2-line Description / Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.textPrimary,
                  height: 1.25,
                ),
              ),
            ),
            SizedBox(height: 6.h),

            // Price Row: Current Bold Price + Strikethrough Original Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$${product.currentPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF000000),
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '\$${product.originalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB0B3BD),
                      decoration: TextDecoration.lineThrough,
                      decorationColor: const Color(0xFFFF334B),
                      decorationThickness: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
