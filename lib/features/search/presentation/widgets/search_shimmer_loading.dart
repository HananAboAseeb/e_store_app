import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';

class SearchShimmerLoading extends StatelessWidget {
  const SearchShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray200,
      highlightColor: AppColors.gray50,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              // Search input shimmer
              Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              SizedBox(height: 28.h),

              // Search History header shimmer
              Container(
                width: 140.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 12.h),

              // Chips shimmer
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(
                  5,
                  (i) => Container(
                    width: 70.w + (i * 15.w),
                    height: 38.h,
                    decoration: BoxDecoration(
                      color: AppColors.gray200,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Recommendations header shimmer
              Container(
                width: 160.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 12.h),

              // Recommendations chips shimmer
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(
                  5,
                  (i) => Container(
                    width: 65.w + (i * 18.w),
                    height: 38.h,
                    decoration: BoxDecoration(
                      color: AppColors.gray200,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Discover header shimmer
              Container(
                width: 100.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 12.h),

              // Discover carousel cards shimmer
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      width: 145.w,
                      height: 220.h,
                      margin: EdgeInsets.only(right: 14.w),
                      decoration: BoxDecoration(
                        color: AppColors.gray200,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
