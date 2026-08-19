import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/primary_button.dart';

class AuthActionSection extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final bool isLoading;
  final String cancelText;
  final VoidCallback? onCancelPressed;
  final double topGap;
  final double bottomGap;

  const AuthActionSection({
    super.key,
    this.buttonText = 'Next',
    this.onButtonPressed,
    this.isLoading = false,
    this.cancelText = 'Cancel',
    this.onCancelPressed,
    this.topGap = 24.0,
    this.bottomGap = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
          text: buttonText,
          isLoading: isLoading,
          onPressed: onButtonPressed,
        ),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: onCancelPressed ?? () => context.pop(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              cancelText,
              style: AppTypography.body.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
        SizedBox(height: bottomGap.h),
      ],
    );
  }
}
