import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';

class SettingsMenuItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? titleColor;
  final Color? chevronColor;

  const SettingsMenuItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.showDivider = true,
    this.titleColor,
    this.chevronColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.r),
          child: Container(
            height: 62.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    title,
                    style: AppTypography.body.copyWith(
                      fontFamily: 'Raleway',
                      color: titleColor ?? AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  AppText(
                    subtitle!,
                    style: AppTypography.bodySmall.copyWith(
                      fontFamily: 'Raleway',
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w),
                ],
                Icon(
                  Icons.chevron_right,
                  size: 20.sp,
                  color: chevronColor ?? AppColors.gray400,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(
            height: 1.5.h,
            margin: EdgeInsets.symmetric(horizontal: 12.5.w),
            color: AppColors.settingsDivider,
          ),
      ],
    );
  }
}
