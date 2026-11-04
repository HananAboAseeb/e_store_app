import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ChatScrollToBottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const ChatScrollToBottomButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 28.sp,
          color: AppColors.primary400,
        ),
      ),
    );
  }
}
