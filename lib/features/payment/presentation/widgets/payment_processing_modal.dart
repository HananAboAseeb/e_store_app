import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class PaymentProcessingModal extends StatelessWidget {
  const PaymentProcessingModal({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.black.withOpacity(0.15),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: const SizedBox.expand(),
            ),
          ),
          const Center(
            child: PaymentProcessingModal(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Container(
          width: 320.w,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circular grey badge with blue progress spinner
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceAddress,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 32.w,
                      height: 32.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.sm),

                // Title: "Payment in Progress"
                Text(
                  'Payment in Progress',
                  textAlign: TextAlign.center,
                  style: AppTypography.h2.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),

                // Subtitle: "Please, wait a few moments"
                Text(
                  'Please, wait a few moments',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
