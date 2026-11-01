import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_container.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/announcement_entity.dart';
import '../../domain/entities/profile_enums.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity announcement;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isVoucher =
        announcement.type == ProfileAnnouncementType.voucherExpiring;
    final isReward = announcement.type == ProfileAnnouncementType.rewardEarned;
    final isRegular = announcement.type == ProfileAnnouncementType.regular;

    final bgColor =
        isVoucher ? AppColors.rewardBackground : AppColors.surfaceAnnouncement;

    return GestureDetector(
      onLongPress: onLongPress,
      child: AppContainer(
        width: 340.w,
        constraints: BoxConstraints(minHeight: 74.h),
        backgroundColor: bgColor,
        borderRadius: BorderRadius.circular(16.r),
        padding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        onTap: onTap ??
            () {
              final route = announcement.actionRoute ?? RouteNames.kRewardsPage;
              context.push(route);
            },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Icon Badge for Reward or Voucher Expiring
            if (isReward) ...[
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.primary400,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.sm),
            ] else if (isVoucher) ...[
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: AppColors.voucherWarningBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.shopping_bag,
                    color: AppColors.voucherWarning,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.sm),
            ],

            // Title & Subtitle using Design System AppText
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.h3(
                    announcement.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  AppText.caption(
                    announcement.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors
                          .textPrimary, // Black text per user requirement
                      height: 1.18,
                    ),
                  ),
                ],
              ),
            ),

            // Right Action Arrow for Regular State
            if (isRegular) ...[
              SizedBox(width: AppSpacing.xs),
              GestureDetector(
                onTap: onTap ?? () => context.push(RouteNames.kRewardsPage),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary400,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.textWhite,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
