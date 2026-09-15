import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(maxLength, (index) {
          // Determine value at index
          final String digit = index < pin.length ? pin[index] : '';
          final bool isFocused = index == pin.length;

          // Determine border and background colors based on state
          Color backgroundColor = AppColors.surface;
          BorderSide borderSide = BorderSide.none;

          if (hasError) {
            borderSide = const BorderSide(color: AppColors.error, width: 1.5);
            backgroundColor = const Color(0xFFFFECEB);
          } else if (isSuccess) {
            borderSide = const BorderSide(color: AppColors.success, width: 1.5);
            backgroundColor = const Color(0xFFEBF9EF);
          } else if (isFocused) {
            borderSide =
                const BorderSide(color: AppColors.primary400, width: 1.5);
            backgroundColor = AppColors.background;
          }

          return Container(
            width: 52.w,
            height: 56.h,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: borderSide != BorderSide.none
                  ? Border.fromBorderSide(borderSide)
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              digit,
              style: AppTypography.h1.copyWith(
                fontSize: 24.sp,
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
      ),
    );
  }
}
