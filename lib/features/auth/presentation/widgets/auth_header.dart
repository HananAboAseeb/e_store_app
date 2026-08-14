import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? topLeading;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.topLeading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAlignment.start,
      children: [
        Stack(
          children: [
            // Decorative Gradient Blob Top Area
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary700.withValues(alpha: 0.15),
                    AppColors.primary400.withValues(alpha: 0.02),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
              ),
            ),
            if (topLeading != null)
              Positioned(
                top: 50.h,
                left: 16.w,
                child: topLeading!,
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Text(
                title,
                style: AppTypography.h1,
              ),
              SizedBox(height: 8.h),
              Text(
                subtitle,
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
