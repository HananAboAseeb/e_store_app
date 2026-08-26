import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isCentered;
  final double titleFontSize;
  final double? titleHeight;

  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.isCentered = false,
    this.titleFontSize = 34.0,
    this.titleHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          style: AppTypography.h1.copyWith(
            fontSize: titleFontSize.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: titleHeight,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 12.h),
          Text(
            subtitle!,
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}
