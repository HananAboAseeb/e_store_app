import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ReviewDoneDialog extends StatefulWidget {
  const ReviewDoneDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: AppColors.black.withOpacity(0.3),
      builder: (context) => const ReviewDoneDialog(),
    );
  }

  @override
  State<ReviewDoneDialog> createState() => _ReviewDoneDialogState();
}

class _ReviewDoneDialogState extends State<ReviewDoneDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).maybePop();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: GestureDetector(
        onTap: () => Navigator.of(context).maybePop(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Blue checkmark circle
              Container(
                width: 72.w,
                height: 72.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 38.sp,
                  color: AppColors.textWhite,
                ),
              ),

              SizedBox(height: 20.h),

              // Done! Title
              Text(
                'Done!',
                style: AppTypography.h1.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 24.sp,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Text(
                'Your review has been successfully sent',
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                ),
              ),

              SizedBox(height: 20.h),

              // 5 Golden Stars (reusing star pattern)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Icon(
                      Icons.star_rounded,
                      size: 26.sp,
                      color: AppColors.starGold,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
