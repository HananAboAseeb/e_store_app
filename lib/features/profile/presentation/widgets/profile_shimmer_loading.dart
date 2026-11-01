import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_shimmer.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      children: [
        // Header
        Row(
          children: [
            CustomShimmer.circular(width: 42.w, height: 42.w),
            SizedBox(width: 8.w),
            CustomShimmer(width: 95.w, height: 34.h, borderRadius: 20.r),
            const Spacer(),
            CustomShimmer.circular(width: 34.w, height: 34.w),
            SizedBox(width: 6.w),
            CustomShimmer.circular(width: 34.w, height: 34.w),
            SizedBox(width: 6.w),
            CustomShimmer.circular(width: 34.w, height: 34.w),
          ],
        ),
        SizedBox(height: AppSpacing.md),

        // Greeting
        CustomShimmer(width: 180.w, height: 30.h, borderRadius: 8.r),
        SizedBox(height: AppSpacing.md),

        // Announcement card
        CustomShimmer(width: double.infinity, height: 75.h, borderRadius: 16.r),
        SizedBox(height: AppSpacing.md),

        // Recently viewed
        CustomShimmer(width: 140.w, height: 20.h, borderRadius: 6.r),
        SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CustomShimmer(
                  width: 72.w,
                  height: 72.w,
                  borderRadius: 16.r,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),

        // My Orders
        CustomShimmer(width: 100.w, height: 20.h, borderRadius: 6.r),
        SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            CustomShimmer(width: 75.w, height: 34.h, borderRadius: 20.r),
            SizedBox(width: AppSpacing.xs),
            CustomShimmer(width: 85.w, height: 34.h, borderRadius: 20.r),
            SizedBox(width: AppSpacing.xs),
            CustomShimmer(width: 85.w, height: 34.h, borderRadius: 20.r),
          ],
        ),
        SizedBox(height: AppSpacing.md),

        // Stories
        CustomShimmer(width: 80.w, height: 20.h, borderRadius: 6.r),
        SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: List.generate(
              3,
              (index) => Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CustomShimmer(
                  width: 105.w,
                  height: 155.h,
                  borderRadius: 16.r,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
