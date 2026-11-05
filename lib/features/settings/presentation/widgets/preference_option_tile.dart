import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/verified_check_badge.dart';

class PreferenceOptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PreferenceOptionTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = isSelected ? 60.h : 48.h;
    final bgColor =
        isSelected ? AppColors.selectedOptionBg : AppColors.unselectedOptionBg;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                label,
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              if (isSelected) VerifiedCheckBadge(size: 24.w),
            ],
          ),
        ),
      ),
    );
  }
}
