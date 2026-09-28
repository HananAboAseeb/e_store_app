import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class PaymentFailureModal extends StatelessWidget {
  final VoidCallback onTryAgain;
  final VoidCallback onChange;

  const PaymentFailureModal({
    super.key,
    required this.onTryAgain,
    required this.onChange,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onTryAgain,
    required VoidCallback onChange,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: AppColors.black.withOpacity(0.15),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: const SizedBox.expand(),
            ),
          ),
          Center(
            child: PaymentFailureModal(
              onTryAgain: onTryAgain,
              onChange: onChange,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
              // Circular grey badge with exclamation icon
              Container(
                width: 64.w,
                height: 64.w,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceAddress,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.sm),

              // Title: "We couldn't proceed your payment"
              Text(
                "We couldn't proceed\nyour payment",
                textAlign: TextAlign.center,
                style: AppTypography.h2.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.25,
                ),
              ),
              SizedBox(height: AppSpacing.xs),

              // Subtitle: "Please, change your payment method or try again"
              Text(
                'Please, change your payment method or try again',
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: AppSpacing.md),

              // Two side-by-side action buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: onTryAgain,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Try Again',
                          style: AppTypography.buttonText.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: onChange,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surfaceOption,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Change',
                          style: AppTypography.buttonText.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
