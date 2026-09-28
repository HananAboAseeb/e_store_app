import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class JustForYouCard extends StatelessWidget {
  final VoidCallback? onTap;

  const JustForYouCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        margin: EdgeInsets.symmetric(horizontal: 16.5.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.06),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.star_outline_rounded,
              color: AppColors.primary,
              size: 22,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Just for you',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              width: 28.r,
              height: 28.r,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: AppColors.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
