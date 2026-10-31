import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/verified_check_badge.dart';

class ReviewDoneDialog extends StatefulWidget {
  const ReviewDoneDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: AppColors.black.withOpacity(0.18),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: const SizedBox.expand(),
            ),
          ),
          const ReviewDoneDialog(),
        ],
      ),
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
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: GestureDetector(
        onTap: () => Navigator.of(context).maybePop(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 34.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Concentric Checkmark Badge matching Figma Screen 67
              Container(
                width: 68.w,
                height: 68.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF5FF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: VerifiedCheckBadge(
                  size: 46.w,
                  backgroundColor: const Color(0xFF004BFE),
                  checkColor: Colors.white,
                ),
              ),

              SizedBox(height: 18.h),

              // Done! Title
              Text(
                'Done!',
                style: AppTypography.h1.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                  color: const Color(0xFF111827),
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle (exact Figma Screen 67 wording)
              Text(
                'You review has been successfully sent',
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(
                  color: const Color(0xFF6B7280),
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 22.h),

              // 5 Golden Stars matching Figma Screen 67
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Icon(
                      Icons.star_rounded,
                      size: 28.sp,
                      color: const Color(0xFFFFA800),
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
