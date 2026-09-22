import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRatingRow extends StatelessWidget {
  final String title;
  final double rating;
  final int reviewCount;
  final VoidCallback onReviewsTap;

  const ProductRatingRow({
    super.key,
    required this.title,
    required this.rating,
    required this.reviewCount,
    required this.onReviewsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Title
          Text(
            title,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF000000),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 10.h),

          // Rating & Comments Row
          Row(
            children: [
              // Rating Badge (Yellow pill)
              Container(
                height: 28.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFAE00).withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 16.sp,
                      color: const Color(0xFFFFAE00),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),

              // Comments pill button
              GestureDetector(
                onTap: onReviewsTap,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 28.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECECEC),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$reviewCount Comments',
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF666666),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16.sp,
                        color: const Color(0xFF888888),
                      ),
                    ],
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
