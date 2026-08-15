import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class PinInput extends StatelessWidget {
  final String pin;
  final int maxLength;
  final bool hasError;
  final bool isSuccess;

  const PinInput({
    super.key,
    required this.pin,
    this.maxLength = 4,
    this.hasError = false,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxLength, (index) {
        // Determine value at index
        final String digit = index < pin.length ? pin[index] : '';
        final bool isFocused = index == pin.length;

        // Determine border and background colors based on state
        const Color backgroundColor = AppColors.surface;
        BorderSide borderSide = BorderSide.none;

        if (hasError) {
          borderSide = const BorderSide(color: AppColors.error, width: 2.0);
        } else if (isSuccess) {
          borderSide = const BorderSide(color: AppColors.success, width: 2.0);
        } else if (isFocused) {
          borderSide = const BorderSide(color: AppColors.primary400, width: 2.0);
        }

        return Container(
          width: 64.w,
          height: 64.w,
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
            border: borderSide != BorderSide.none ? Border.fromBorderSide(borderSide) : null,
          ),
          alignment: Alignment.center,
          child: Text(
            digit,
            style: AppTypography.h1.copyWith(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: hasError
                  ? AppColors.error
                  : isSuccess
                      ? AppColors.success
                      : AppColors.textPrimary,
            ),
          ),
        );
      }),
    );
  }
}
