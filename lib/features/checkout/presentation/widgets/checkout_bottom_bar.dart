import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double total;
  final VoidCallback onPay;

  const CheckoutBottomBar({
    super.key,
    required this.total,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
            width: 1.w,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Total amount
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total: ',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: AppTypography.h2.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // Pay Button: W: 144, H: 36 (From Figma specs)
            GestureDetector(
              onTap: onPay,
              child: Container(
                width: 144.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Pay',
                  style: AppTypography.buttonText.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
