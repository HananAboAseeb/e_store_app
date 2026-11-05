import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.25),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return const DeleteAccountDialog();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 342.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 4.h),
                // Circular Warning Badge with custom Figma exclamation mark (72x72)
                const WarningExclamationBadge(),
                SizedBox(height: 18.h),

                // Title (Exact Figma: Raleway 700, 18px, centered)
                AppText(
                  'You are going to delete\nyour account',
                  textAlign: TextAlign.center,
                  style: AppTypography.h3.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
                SizedBox(height: 10.h),

                // Subtitle (Exact Figma: 13px, secondary grey)
                AppText(
                  "You won't be able to restore your data",
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 26.h),

                // Buttons: Cancel (Black) & Delete (Red) - Exact Figma size: 142x38, gap: 12
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 142.w,
                      height: 38.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    SizedBox(
                      width: 142.w,
                      height: 38.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19.r),
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Pixel-Perfect Exclamation Badge from Figma Screen 99.
/// Circle diameter: 72px, Background: #E6E6E6.
/// Pill bar: 8x24px, gap: 4px, Dot: 8x8px circle. Color: #737373.
class WarningExclamationBadge extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  const WarningExclamationBadge({
    super.key,
    this.size = 72,
    this.backgroundColor = const Color(0xFFE6E6E6),
    this.iconColor = const Color(0xFF737373),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SizedBox(
          width: 8.w,
          height: 36.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
