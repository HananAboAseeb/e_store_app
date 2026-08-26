import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/primary_button.dart';

class AuthButtonGroup extends StatelessWidget {
  final String primaryText;
  final VoidCallback? onPrimaryPressed;
  final String? cancelText;
  final VoidCallback? onCancelPressed;
  final bool isLoading;

  const AuthButtonGroup({
    super.key,
    required this.primaryText,
    this.onPrimaryPressed,
    this.cancelText = 'Cancel',
    this.onCancelPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
          text: primaryText,
          isLoading: isLoading,
          onPressed: onPrimaryPressed,
        ),
        if (cancelText != null) ...[
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: onCancelPressed ?? () => context.pop(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                cancelText!,
                style: AppTypography.body.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
        SizedBox(height: 16.h),
      ],
    );
  }
}
