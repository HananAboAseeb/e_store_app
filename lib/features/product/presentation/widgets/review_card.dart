import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/review_entity.dart';

class ReviewCard extends StatelessWidget {
  final ReviewEntity review;
  final VoidCallback? onLikeTap;
  final VoidCallback? onDislikeTap;

  const ReviewCard({
    super.key,
    required this.review,
    this.onLikeTap,
    this.onDislikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Avatar + Name + Stars
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: const Color(0xFFE5E5EA),
                backgroundImage: AssetImage(review.authorAvatar),
                onBackgroundImageError: (_, __) {},
                child: review.authorAvatar.isEmpty
                    ? Text(
                        review.authorName.isNotEmpty
                            ? review.authorName[0]
                            : '?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.authorName,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: List.generate(5, (index) {
                        final filled = index < review.rating.floor();
                        return Icon(
                          filled
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 15.sp,
                          color: const Color(0xFFFFAE00),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Review Text
          Text(
            review.text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),

          // Footer: Dislikes, Likes, Date
          Row(
            children: [
              // Dislike
              GestureDetector(
                onTap: onDislikeTap,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Text(
                      '${review.dislikes}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: review.userVote == false
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.arrow_downward,
                      size: 14.sp,
                      color: review.userVote == false
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),

              // Like
              GestureDetector(
                onTap: onLikeTap,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Text(
                      '${review.likes}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: review.userVote == true
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.arrow_upward,
                      size: 14.sp,
                      color: review.userVote == true
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Timestamp
              Text(
                review.timeAgo,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
