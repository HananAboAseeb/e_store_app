import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class JustForYouHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const JustForYouHeader({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title Row with Back Button ──
          Row(
            children: [
              GestureDetector(
                onTap: onBack ?? () => context.pop(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 24.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // ── "Just for you" Section Row ──
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                size: 22.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                'Just for you',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
