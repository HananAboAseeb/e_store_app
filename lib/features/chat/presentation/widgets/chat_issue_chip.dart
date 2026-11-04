import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/verified_check_badge.dart';

class ChatIssueChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ChatIssueChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 36.h,
          margin: EdgeInsets.only(bottom: 6.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          constraints: BoxConstraints(
            maxWidth: 1.0.sw,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary400 : AppColors.white,
            borderRadius: BorderRadius.circular(42.r),
            border: isSelected
                ? null
                : Border.all(
                    color: AppColors.primary400,
                    width: 1.5.w,
                  ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isSelected) ...[
                VerifiedCheckBadge(
                  size: 18.w,
                  backgroundColor: AppColors.white,
                  checkColor: AppColors.primary400,
                ),
                SizedBox(width: 8.w),
              ],
              Flexible(
                child: AppText.body(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        isSelected ? AppColors.textWhite : AppColors.primary400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
