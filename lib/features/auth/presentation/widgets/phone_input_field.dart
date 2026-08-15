import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String selectedCountryFlag;
  final String selectedDialCode;
  final VoidCallback? onCountryTap;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final String hintText;

  const PhoneInputField({
    super.key,
    this.controller,
    this.selectedCountryFlag = '🇺🇸',
    this.selectedDialCode = '+1',
    this.onCountryTap,
    this.onChanged,
    this.validator,
    this.hintText = 'Your number',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: TextInputType.phone,
        onChanged: onChanged,
        style: AppTypography.body,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.bodySmall,
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          prefixIcon: GestureDetector(
            onTap: onCountryTap,
            child: Container(
              padding: EdgeInsets.only(left: 14.w, right: 10.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedCountryFlag,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    selectedDialCode,
                    style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.textSecondary,
                    size: 20.sp,
                  ),
                  Container(
                    height: 24.h,
                    width: 1.w,
                    margin: EdgeInsets.only(left: 8.w, right: 12.w),
                    color: AppColors.border,
                  ),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppColors.inputRadius.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppColors.inputRadius.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppColors.inputRadius.r),
            borderSide: const BorderSide(color: AppColors.primary400, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppColors.inputRadius.r),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppColors.inputRadius.r),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
        ),
      ),
    );
  }
}
