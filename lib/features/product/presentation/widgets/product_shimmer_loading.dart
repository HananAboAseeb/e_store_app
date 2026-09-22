import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerLoading extends StatelessWidget {
  const ProductShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFEEEEEE),
      highlightColor: const Color(0xFFF8F8F8),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gallery skeleton
            Container(
              height: 380.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            SizedBox(height: 16.h),

            // Breadcrumb skeleton
            Container(
              height: 16.h,
              width: 140.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 12.h),

            // Title skeleton
            Container(
              height: 24.h,
              width: 220.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 12.h),

            // Rating skeleton
            Container(
              height: 24.h,
              width: 160.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 20.h),

            // Color variants skeleton
            Row(
              children: List.generate(3, (index) {
                return Container(
                  width: 68.w,
                  height: 68.w,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                );
              }),
            ),
            SizedBox(height: 20.h),

            // Size skeleton
            Container(
              height: 38.h,
              width: 70.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
