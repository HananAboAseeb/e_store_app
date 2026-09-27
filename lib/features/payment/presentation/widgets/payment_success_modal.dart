import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class PaymentSuccessModal extends StatelessWidget {
  final VoidCallback onTrackOrder;

  const PaymentSuccessModal({
    super.key,
    required this.onTrackOrder,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onTrackOrder,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.black.withValues(alpha: 0.15),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: const SizedBox.expand(),
            ),
          ),
          Center(
            child: PaymentSuccessModal(
              onTrackOrder: onTrackOrder,
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
            // Circular grey badge with inner blue checkmark circle
            Container(
              width: 64.w,
              height: 64.w,
              decoration: const BoxDecoration(
                color: AppColors.surfaceAddress,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.sm),

            // Title: "Done!"
            Text(
              'Done!',
              textAlign: TextAlign.center,
              style: AppTypography.h2.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.xs),

            // Subtitle: "Your card has been successfully charged"
            Text(
              'Your card has been successfully charged',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: AppSpacing.md),

            // Grey pill button: "Track your Order"
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: ElevatedButton(
                onPressed: onTrackOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceOption,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                child: Text(
                  'Track your Order',
                  style: AppTypography.buttonText.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}
