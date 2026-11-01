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
        SizedBox(height: 4.h),

        // Shared Design System Card Title (Figma: Raleway, 700, 16px, line-height: 19px, letter-spacing: -0.15px)
        AppText.cardTitle(
          reward.title,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),

        // Shared Design System Card Description (Figma: Nunito Sans, 400, 12px, line-height: 18px, letter-spacing: 0px)
        AppText.cardDescription(
          reward.description,
          textAlign: TextAlign.center,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
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
        // App logo (ShopX_logo.png): white bag silhouette with blue 'S' in center
        whiteIcon = ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            -1.0, 0, 0, 0, 255,
            -0.702, 0, 0, 0, 255,
            0, 0, 0, 0, 255,
            0, 0, 0, 1.0, 0,
          ]),
          child: Image.asset(
            'assets/images/ShopX_logo.png',
            width: 34.w,
            height: 34.w,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              Icons.shopping_bag,
              color: AppColors.white,
              size: 32.sp,
            ),
          ),
        );
      } else {
        // Heart icon in Loyal Customer: larger size matching Figma (38sp)
        whiteIcon = Icon(
          Icons.favorite,
          color: AppColors.white,
          size: 38.sp,
        );
      }

      final squircleBadge = Container(
        width: 74.w,
        height: 74.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: AppColors.primary400,
            width: 1.8.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.14),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(4.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary400,
            borderRadius: BorderRadius.circular(16.r),
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
      // Bottom 4: Circular container with distinct dark gray drop shadow surrounding all sides
      // Layering: Outer white with dark shadow -> 3px blue circle (Figma Rectangle 1141: 62x62) -> white inside -> icon
      Widget innerIcon;
      switch (reward.iconType) {
        case 'star':
          // Matching Star 31 in Figma Dev Mode (46px x 46px)
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
            width: 38.w,
            height: 38.w,
            color: AppColors.primary400,
            errorBuilder: (_, __, ___) => Icon(
              Icons.checkroom,
              color: AppColors.primary400,
              size: 38.sp,
            ),
          );
          break;
        case 'smile':
          // Solid blue circle face with white eyes and white smile matching Figma
          innerIcon = Container(
            width: 38.w,
            height: 38.w,
            decoration: const BoxDecoration(
              color: AppColors.primary400,
              shape: BoxShape.circle,
            ),
            child: const CustomPaint(
              painter: _SmileyFeaturesPainter(color: AppColors.white),
            ),
          );
          break;
        default:
          innerIcon = Icon(
            Icons.emoji_events,
            color: AppColors.primary400,
            size: 38.sp,
          );
      }

      final circleBadge = Container(
        width: 74.w,
        height: 74.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.24), // Rich, dark gray shadow surrounding all sides
              blurRadius: 14,
              spreadRadius: 1.5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 62.w,
            height: 62.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary400,
                width: 3.w, // Exactly 3px from Figma Rectangle 1141
              ),
            ),
            child: Center(child: innerIcon),
          ),
        ),
      );

      return SizedBox(
        width: 80.w,
        height: 80.w,
        child: Center(child: circleBadge),
      );
    }
  }
}

/// Custom painter for the white eyes and white curved smile inside the blue face disk
class _SmileyFeaturesPainter extends CustomPainter {
  final Color color;

  const _SmileyFeaturesPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final eyePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final smilePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    // Eyes: two filled white dots inside the blue face
    final eyeRadius = size.width * 0.09;
    final eyeY = size.height * 0.36;
    final leftEyeX = size.width * 0.32;
    final rightEyeX = size.width * 0.68;

    canvas.drawCircle(Offset(leftEyeX, eyeY), eyeRadius, eyePaint);
    canvas.drawCircle(Offset(rightEyeX, eyeY), eyeRadius, eyePaint);

    // Smile: smooth curved arc in white
    final smilePath = Path()
      ..moveTo(size.width * 0.26, size.height * 0.54)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.78,
        size.width * 0.74,
        size.height * 0.54,
      );

    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(covariant _SmileyFeaturesPainter oldDelegate) =>
      oldDelegate.color != color;
}
