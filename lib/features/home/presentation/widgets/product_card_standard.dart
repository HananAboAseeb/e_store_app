import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/home_data_entity.dart';

class ProductCardStandard extends StatelessWidget {
  final HomeProductEntity product;
  final double? width;
  final double? imageHeight;
  final VoidCallback? onTap;
  final bool showNewBadge;

  const ProductCardStandard({
    super.key,
    required this.product,
    this.width,
    this.imageHeight,
    this.onTap,
    this.showNewBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? 140.w;
    final imgHeight = imageHeight ?? 140.h;
    const grayBg = Color(0xFFE5E6EA);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // White Outer Card with Shadow framing Gray Image Container
            Stack(
              children: [
                Container(
                  width: cardWidth,
                  height: imgHeight,
                  padding: EdgeInsets.all(6.w),
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
                  child: Container(
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
                ),
                if (showNewBadge ||
                    (product.tag != null &&
                        product.tag!.toLowerCase() == 'new'))
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary400,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'NEW',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),

            // Title
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                fontSize: 12.sp,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
            SizedBox(height: 4.h),

            // Price formatted as $17,00
            Text(
              '\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
