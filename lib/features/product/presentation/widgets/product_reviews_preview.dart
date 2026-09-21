import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/review_entity.dart';
import 'review_card.dart';

class ProductReviewsPreview extends StatelessWidget {
  final List<ReviewEntity> reviews;
  final int totalReviews;
  final VoidCallback onViewAllTap;

  const ProductReviewsPreview({
    super.key,
    required this.reviews,
    required this.totalReviews,
    required this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF000000),
            ),
          ),
          SizedBox(height: 12.h),

          // Preview cards
          ...reviews.map((r) => ReviewCard(review: r)),

          SizedBox(height: 4.h),

          // View All Reviews button
          PrimaryButton(
            text: 'View All $totalReviews Reviews',
            height: 48.h,
            onPressed: onViewAllTap,
          ),
        ],
      ),
    );
  }
}
