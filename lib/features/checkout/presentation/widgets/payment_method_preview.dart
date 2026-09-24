import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class PaymentMethodPreview extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String> onSelectMethod;

  const PaymentMethodPreview({
    super.key,
    required this.selectedMethod,
    required this.onSelectMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: AppTypography.h2.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            // Card Option
            _buildMethodChip(
              id: 'card',
              title: 'Card',
              isSelected: selectedMethod == 'card',
            ),
            SizedBox(width: 12.w),

            // Paypal Option
            _buildMethodChip(
              id: 'paypal',
              title: 'Paypal',
              isSelected: selectedMethod == 'paypal',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMethodChip({
    required String id,
    required String title,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onSelectMethod(id),
      child: Container(
        width: 123.w,
        height: 48.h,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySoft : AppColors.surfaceOption,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22.h,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : AppColors.transparent,
                border: isSelected
                    ? null
                    : Border.all(
                        color: AppColors.gray400,
                        width: 1.5.w,
                      ),
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 14.sp,
                      color: AppColors.white,
                    )
                  : null,
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                title,
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
