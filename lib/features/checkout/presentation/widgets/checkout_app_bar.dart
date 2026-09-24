import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onClose;

  const CheckoutAppBar({
    super.key,
    this.onClose,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Payment',
              style: AppTypography.h1.copyWith(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: onClose ??
                  () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
              child: Container(
                width: 36.h,
                height: 36.h,
                decoration: const BoxDecoration(
                  color: AppColors.gray100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
