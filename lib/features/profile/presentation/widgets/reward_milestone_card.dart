import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/reward_milestone_entity.dart';

class RewardMilestoneCard extends StatelessWidget {
  final RewardMilestoneEntity reward;

  const RewardMilestoneCard({
    super.key,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon with optional checkmark badge
        _buildIconBadge(),
        SizedBox(height: 10.h),

        // Title (Bold, Black)
        AppText.h3(
          reward.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),

        // Description (Muted, readable, exactly matching Figma)
        AppText.caption(
          reward.description,
          textAlign: TextAlign.center,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  Widget _buildIconBadge() {
    final isSquare = reward.isEarned ||
        reward.iconType == 'bag' ||
        reward.iconType == 'heart';

    if (isSquare) {
      // Top 2: Double-contour squircle matching Figma Screen 84
      // Outer thin primary blue border -> white padding -> inner solid blue squircle -> white icon
      Widget whiteIcon;
      if (reward.iconType == 'bag') {
        whiteIcon = Image.asset(
          'assets/images/icons/Bag 2.png',
          width: 28.w,
          height: 28.w,
          color: AppColors.white,
          errorBuilder: (_, __, ___) => Icon(
            Icons.shopping_bag,
            color: AppColors.white,
            size: 28.sp,
          ),
        );
      } else {
        whiteIcon = Icon(
          Icons.favorite,
          color: AppColors.white,
          size: 28.sp,
        );
      }

      final squircleBadge = Container(
        width: 74.w,
        height: 74.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.primary400,
            width: 1.8.w,
          ),
        ),
        padding: EdgeInsets.all(3.5.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary400,
            borderRadius: BorderRadius.circular(19.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary400.withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(child: whiteIcon),
        ),
      );

      return SizedBox(
        width: 80.w,
        height: 80.w,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            squircleBadge,
            if (reward.isEarned)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary400,
                    border: Border.all(
                      color: AppColors.white,
                      width: 2.w,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 13.sp,
                      weight: 700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      // Bottom 4: Clean white circular badge with crisp thin blue border matching Figma Screen 84
      // No heavy gray shadow; larger icons (44-46px) matching Star 31 (46x46 in Figma)
      Widget innerIcon;
      switch (reward.iconType) {
        case 'star':
          innerIcon = Icon(
            Icons.star,
            color: AppColors.primary400,
            size: 44.sp,
          );
          break;
        case 'cloud':
          innerIcon = Icon(
            Icons.cloud,
            color: AppColors.primary400,
            size: 44.sp,
          );
          break;
        case 'shirt':
          innerIcon = Image.asset(
            'assets/images/icons/Vector_clothes.png',
            width: 42.w,
            height: 42.w,
            color: AppColors.primary400,
            errorBuilder: (_, __, ___) => Icon(
              Icons.checkroom,
              color: AppColors.primary400,
              size: 42.sp,
            ),
          );
          break;
        case 'smile':
          innerIcon = Image.asset(
            'assets/images/icons/Ellipse 295.png',
            width: 42.w,
            height: 42.w,
            color: AppColors.primary400,
            errorBuilder: (_, __, ___) => Icon(
              Icons.sentiment_satisfied_alt,
              color: AppColors.primary400,
              size: 42.sp,
            ),
          );
          break;
        default:
          innerIcon = Icon(
            Icons.emoji_events,
            color: AppColors.primary400,
            size: 42.sp,
          );
      }

      final circleBadge = Container(
        width: 74.w,
        height: 74.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary400,
            width: 1.8.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary400.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: innerIcon),
      );

      return SizedBox(
        width: 80.w,
        height: 80.w,
        child: Center(child: circleBadge),
      );
    }
  }
}
