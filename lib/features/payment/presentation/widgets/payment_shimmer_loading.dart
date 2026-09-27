import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class PaymentShimmerLoading extends StatelessWidget {
  const PaymentShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray200,
      highlightColor: AppColors.gray50,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sheet title and close button skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 24.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                Container(
                  height: 32.h,
                  width: 32.w,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),

            // Horizontal card item skeleton
            SizedBox(
              height: 140.h,
              child: Row(
                children: [
                  Container(
                    width: 220.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Container(
                    width: 50.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
