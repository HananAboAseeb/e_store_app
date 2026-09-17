import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ImageSelectionFrame extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onViewResults;

  const ImageSelectionFrame({
    super.key,
    required this.onRetry,
    required this.onViewResults,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Bounding Selection Frame in Center
        Center(
          child: GestureDetector(
            onTap: onViewResults,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 250.w,
              height: 320.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.black,
                  width: 3.w,
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          ),
        ),

        // Bottom Action Row with White "Retry" Pill Button
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.h,
          child: Center(
            child: GestureDetector(
              onTap: onRetry,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Text(
                  'Retry',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
