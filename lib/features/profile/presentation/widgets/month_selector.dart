import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_container.dart';
import '../../../../shared/widgets/app_text.dart';

class MonthSelector extends StatelessWidget {
  final String month;

  const MonthSelector({
    super.key,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: 340.w,
      height: 36.h,
      borderRadius: BorderRadius.circular(48.r),
      backgroundColor: AppColors.surfaceAnnouncement,
      alignment: Alignment.center,
      child: AppText.body(
        month,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
