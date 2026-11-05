import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';

class ShippingFieldGroup extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditing;
  final TextEditingController? controller;

  const ShippingFieldGroup({
    super.key,
    required this.label,
    required this.value,
    this.isEditing = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 38.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: AppColors.cardFieldBg,
            borderRadius: BorderRadius.circular(55.r),
          ),
          alignment: Alignment.centerLeft,
          child: isEditing && controller != null
              ? TextField(
                  controller: controller,
                  cursorColor: AppColors.primary,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.transparent,
                    filled: false,
                  ),
                )
              : AppText(
                  value,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
        ),
        SizedBox(height: 14.h),
      ],
    );
  }
}
