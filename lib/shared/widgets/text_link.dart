import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_theme.dart';

class TextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;

  const TextLink({
    super.key,
    required this.text,
    required this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Text(
          text,
          style: style ??
              AppTypography.bodySmall.copyWith(
                color: AppColors.primary400,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
