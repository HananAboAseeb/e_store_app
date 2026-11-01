import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/profile_enums.dart';

class RewardsTabs extends StatelessWidget {
  final RewardsTab activeTab;
  final ValueChanged<RewardsTab> onTabChanged;

  const RewardsTabs({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _TabPill(
            label: 'Active Rewards',
            isActive: activeTab == RewardsTab.activeRewards,
            onTap: () => onTabChanged(RewardsTab.activeRewards),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _TabPill(
            label: 'Progress',
            isActive: activeTab == RewardsTab.progress,
            onTap: () => onTabChanged(RewardsTab.progress),
          ),
        ),
      ],
    );
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabPill({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.h,
        decoration: BoxDecoration(
          color:
              isActive ? AppColors.primarySoft : AppColors.surfaceAnnouncement,
          borderRadius: BorderRadius.circular(18.r),
        ),
        alignment: Alignment.center,
        child: AppText.caption(
          label,
          style: TextStyle(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.bold,
            color: isActive ? AppColors.primary400 : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
