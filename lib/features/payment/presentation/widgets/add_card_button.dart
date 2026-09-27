import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class AddCardButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddCardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52.w,
        height: 145.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
