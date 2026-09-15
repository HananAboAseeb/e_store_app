import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';

class CategoriesShimmerLoading extends StatelessWidget {
  const CategoriesShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray200,
      highlightColor: AppColors.gray50,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gender tabs shimmer
              SizedBox(height: 12.h),
              Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Container(
                      height: 44.h,
                      margin: EdgeInsets.only(right: index < 2 ? 8.w : 0),
                      decoration: BoxDecoration(
                        color: AppColors.gray200,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Accordion tiles shimmer
              ...List.generate(
                5,
                (index) => Container(
                  height: index == 0 ? 260.h : 68.h,
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.gray200,
                    borderRadius: BorderRadius.circular(20.r),
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
