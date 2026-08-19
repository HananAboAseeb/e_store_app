import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String selectedCountryFlag;
  final String selectedDialCode;
  final VoidCallback onCountryTap;
  final String? Function(String?)? validator;
  final String hintText;

  const PhoneInputField({
    super.key,
    this.controller,
    required this.selectedCountryFlag,
    required this.selectedDialCode,
    required this.onCountryTap,
    this.validator,
    this.hintText = 'Your number',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: validator,
      style: AppTypography.body.copyWith(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTypography.bodySmall.copyWith(
          fontSize: 15.sp,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        prefixIcon: GestureDetector(
          onTap: onCountryTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 12.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedCountryFlag,
                  style: TextStyle(fontSize: 18.sp),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.textSecondary,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 1.w,
                  height: 24.h,
                  color: AppColors.border,
                ),
              ],
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.primary400, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.error, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        errorStyle: TextStyle(
          fontSize: 12.sp,
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
