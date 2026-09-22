import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/rating_breakdown_entity.dart';

class ProductRatingsBreakdown extends StatelessWidget {
  final double rating;
  final int scoreCount;
  final List<RatingBreakdownEntity> breakdown;

  const ProductRatingsBreakdown({
    super.key,
    required this.rating,
    required this.scoreCount,
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ratings',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF000000),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF000000),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '$scoreCount Scores',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8E8E93),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Gray Container with ratings tiers
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFFECECEC),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                _buildRatingRow(stars: 5, count: '12345', percent: '20%'),
                SizedBox(height: 6.h),
                _buildRatingRow(stars: 4, count: '12345', percent: '20%'),
                SizedBox(height: 6.h),
                _buildRatingRow(stars: 3, count: '12345', percent: '20%'),
                SizedBox(height: 6.h),
                _buildRatingRow(stars: 2, count: '12345', percent: '20%'),
                SizedBox(height: 6.h),
                _buildRatingRow(stars: 1, count: '12345', percent: '20%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow({
    required int stars,
    required String count,
    required String percent,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 48.w,
          child: Text(
            count,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF555555),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            stars,
            (_) => Icon(
              Icons.star_rounded,
              size: 15.sp,
              color: const Color(0xFFFFAE00),
            ),
          ),
        ),
        const Spacer(),
        Text(
          percent,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF777777),
          ),
        ),
      ],
    );
  }
}
