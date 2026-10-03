import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/primary_button.dart';
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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column: Circle Icon + Vertical Connecting Line
          Column(
            children: [
              // Circle Badge
              _buildMilestoneBadge(),

              // Vertical Connector Line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: step.isCompleted
                        ? AppColors.primary
                        : AppColors.timelineLine,
                  ),
                ),
            ],
          ),

          SizedBox(width: 16.w),

          // Right Column: Title + Timestamp + Action
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: step.isCompleted || step.isFailed
                          ? FontWeight.w700
                          : FontWeight.w500,
                      fontSize: 14.sp,
                      color: step.isFailed
                          ? AppColors.statusFailed
                          : (step.isCompleted
                              ? AppColors.textPrimary
                              : AppColors.textSecondary),
                    ),
                  ),
                  if (step.timestamp != null && step.timestamp!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      step.timestamp!,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                  if (step.isFailed) ...[
                    SizedBox(height: 10.h),
                    PrimaryButton(
                      text: 'Learn more',
                      width: 108.w,
                      height: 32.h,
                      textStyle: AppTypography.buttonText.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      onPressed: onLearnMoreTap,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneBadge() {
    Color bgColor;
    Color iconColor;
    IconData iconData;

    if (step.isFailed) {
      bgColor = AppColors.statusFailed;
      iconColor = AppColors.textWhite;
      iconData = Icons.priority_high_rounded;
    } else if (step.isCompleted) {
      bgColor = AppColors.primary;
      iconColor = AppColors.textWhite;
      iconData = _getIconForType(step.iconType);
    } else {
      bgColor = AppColors.surfaceOption;
      iconColor = AppColors.gray400;
      iconData = _getIconForType(step.iconType);
    }

    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: step.isCompleted
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Icon(
        iconData,
        size: 18.sp,
        color: iconColor,
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'package':
        return Icons.inventory_2_outlined;
      case 'transit':
        return Icons.local_shipping_outlined;
      case 'facility':
        return Icons.warehouse_outlined;
      case 'shipped':
        return Icons.flight_takeoff_rounded;
      case 'delivered':
        return Icons.check_circle_outline_rounded;
      case 'alert':
        return Icons.priority_high_rounded;
      default:
        return Icons.circle;
    }
  }
}
