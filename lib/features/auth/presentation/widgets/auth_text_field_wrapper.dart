import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AuthTextFieldWrapper extends StatelessWidget {
  final Widget child;
  final String? label;
  final String? errorText;
  final double bottomSpacing;

  const AuthTextFieldWrapper({
    super.key,
    required this.child,
    this.label,
    this.errorText,
    this.bottomSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
          ],
          child,
          if (errorText != null && errorText!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Text(
                errorText!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
