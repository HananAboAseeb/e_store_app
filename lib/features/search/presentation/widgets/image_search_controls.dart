import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ImageSearchControls extends StatelessWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;
  final VoidCallback onMoreTap;

  const ImageSearchControls({
    super.key,
    required this.onGalleryTap,
    required this.onCameraTap,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Gallery circular button
          GestureDetector(
            onTap: onGalleryTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 52.w,
              height: 52.h,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.85),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.photo_library_outlined,
                  size: 24.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),

          // Center prominent Primary 400 Camera button
          GestureDetector(
            onTap: onCameraTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 68.w,
              height: 68.h,
              decoration: BoxDecoration(
                color: AppColors.primary400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary400.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 32.sp,
                  color: AppColors.white,
                ),
              ),
            ),
          ),

          // More circular button
          GestureDetector(
            onTap: onMoreTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 52.w,
              height: 52.h,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.85),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.more_horiz,
                  size: 26.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
