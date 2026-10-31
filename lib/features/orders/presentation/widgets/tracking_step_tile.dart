import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/order_entity.dart';

class TrackingStepTile extends StatelessWidget {
  final TrackingStepEntity step;
  final bool isLast;
  final VoidCallback? onLearnMoreTap;

  const TrackingStepTile({
    super.key,
    required this.step,
    this.isLast = false,
    this.onLearnMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Large Circular Badge (54.w x 54.w) matching Figma
          _buildMilestoneBadge(),

          SizedBox(width: 16.w),

          // Right: Title + Timestamp Pill + Learn more action
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Step Title using centralized token
                Text(
                  step.title,
                  style: AppTypography.trackingStepTitle,
                ),

                // Timestamp in neutral gray capsule pill matching Figma inspector (W: 90, H: 22, R: 103)
                if (step.timestamp != null && step.timestamp!.isNotEmpty) ...[
                  SizedBox(height: 5.h),
                  Container(
                    width: 90.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: AppColors.countPillBg,
                      borderRadius: BorderRadius.circular(103.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      step.timestamp!,
                      style: AppTypography.timestampPill,
                    ),
                  ),
                ],

                // Blue "Learn more" button for failed attempt (Screen 60)
                if (step.isFailed) ...[
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: onLearnMoreTap,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 108.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Learn more',
                        style: AppTypography.buttonText.copyWith(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneBadge() {
    Color bgColor;
    Color iconColor;

    if (step.isFailed) {
      // Screen 60: Red location pin badge with X
      bgColor = AppColors.statusFailed;
      iconColor = AppColors.white;
    } else if (step.iconType == 'delivered_orange') {
      // Screen 60: Orange location pin badge
      bgColor = const Color(0xFFFF9500);
      iconColor = AppColors.white;
    } else if (step.isCompleted) {
      // Solid primary blue badge
      bgColor = AppColors.primary;
      iconColor = AppColors.white;
    } else {
      // Pending milestone: light ice blue background with gray icon
      bgColor = const Color(0xFFEBF2FF);
      iconColor = const Color(0xFF64748B);
    }

    final assetPath = _getAssetForStep();

    return Container(
      width: 54.w,
      height: 54.w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: (step.isCompleted ||
                step.isFailed ||
                step.iconType == 'delivered_orange')
            ? [
                BoxShadow(
                  color: bgColor.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Image.asset(
        assetPath,
        width: 25.w,
        height: 25.w,
        fit: BoxFit.contain,
        color: iconColor,
        errorBuilder: (_, __, ___) => Icon(
          Icons.check_circle_outline_rounded,
          size: 24.sp,
          color: iconColor,
        ),
      ),
    );
  }

  String _getAssetForStep() {
    if (step.isFailed || step.iconType == 'alert') {
      return 'assets/images/icons/delivery error logo.png';
    }
    if (step.iconType == 'delivered_orange' ||
        step.iconType == 'delivered' ||
        step.title.toLowerCase().contains('delivered')) {
      return 'assets/images/icons/delivered logo.png';
    }
    if (step.title.toLowerCase().contains('packed') ||
        step.iconType == 'package') {
      return 'assets/images/icons/packed logo.png';
    }
    if (step.title.toLowerCase().contains('way') ||
        step.iconType == 'transit' ||
        step.iconType == 'otwtlf') {
      return 'assets/images/icons/otwtlf logo.png';
    }
    if (step.title.toLowerCase().contains('arrived') ||
        step.iconType == 'facility' ||
        step.iconType == 'aalf') {
      return 'assets/images/icons/aalf logo.png';
    }
    if (step.title.toLowerCase().contains('shipped') ||
        step.iconType == 'shipped') {
      return 'assets/images/icons/shipped logo.png';
    }
    return 'assets/images/icons/packed logo.png';
  }
}
