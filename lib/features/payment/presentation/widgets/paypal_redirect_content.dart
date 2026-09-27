import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/primary_button.dart';

class PayPalRedirectContent extends StatelessWidget {
  final VoidCallback onOkPressed;

  const PayPalRedirectContent({
    super.key,
    required this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.sm),

        // Circular PayPal brand badge
        Container(
          width: 52.w,
          height: 52.w,
          decoration: const BoxDecoration(
            color: AppColors.paypalBlue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'P',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),

        // Instructions text
        Text(
          'You will be directed to PayPal',
          textAlign: TextAlign.center,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppSpacing.md),

        // Centered blue "OK" pill button reusing PrimaryButton
        PrimaryButton(
          text: 'OK',
          onPressed: onOkPressed,
          width: 130.w,
          height: 44.h,
        ),
        SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}
