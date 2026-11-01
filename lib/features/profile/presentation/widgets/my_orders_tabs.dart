import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/red_dot_badge.dart';
import '../../domain/entities/profile_enums.dart';

class MyOrdersTabs extends StatelessWidget {
  final ProfileAnnouncementType announcementType;

  const MyOrdersTabs({
    super.key,
    this.announcementType = ProfileAnnouncementType.regular,
  });

  @override
  Widget build(BuildContext context) {
    // Red dot for regular announcement (Screen 62), green dot for reward/voucher reminder (Screens 81, 85)
    final dotColor = announcementType == ProfileAnnouncementType.regular
        ? AppColors.error
        : AppColors.success;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.h2(
          'My Orders',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            letterSpacing: -0.28,
            height: 1.5,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              // Tab 1: To Pay
              _OrderTabPill(
                label: 'To Pay',
                width: 90.w,
                onTap: () =>
                    context.push('${RouteNames.kOrdersPage}?tab=to_pay'),
              ),
              SizedBox(width: AppSpacing.xs),

              // Tab 2: To Recieve with notification dot (Figma: width 120, height 36, dot 14x14, border 2px)
              RedDotBadge(
                dotSize: 14.r,
                offset: Offset(-2.w, -2.h),
                borderWidth: 2.w,
                borderColor: AppColors.white,
                color: dotColor,
                child: _OrderTabPill(
                  label: 'To Recieve',
                  width: 120.w,
                  onTap: () =>
                      context.push('${RouteNames.kOrdersPage}?tab=to_receive'),
                ),
              ),
              SizedBox(width: AppSpacing.xs),

              // Tab 3: To Review
              _OrderTabPill(
                label: 'To Review',
                width: 110.w,
                onTap: () =>
                    context.push('${RouteNames.kOrdersPage}?tab=to_review'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OrderTabPill extends StatelessWidget {
  final String label;
  final double width;
  final VoidCallback onTap;

  const _OrderTabPill({
    required this.label,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 36.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: AppText.caption(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary400,
          ),
        ),
      ),
    );
  }
}
