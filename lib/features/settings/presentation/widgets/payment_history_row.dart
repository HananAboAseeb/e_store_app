import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/payment_history_entity.dart';

class PaymentHistoryRow extends StatelessWidget {
  final PaymentHistoryEntity transaction;

  const PaymentHistoryRow({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isDebit = transaction.isDebit;
    final bgColor =
        isDebit ? AppColors.historyDebitCardBg : AppColors.surfaceContainer;
    final iconColor =
        isDebit ? AppColors.historyDebitIcon : AppColors.historyCreditIcon;
    final amountColor =
        isDebit ? AppColors.historyDebitIcon : AppColors.textPrimary;

    return Container(
      width: double.infinity,
      height: 60.h,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          // Shopping bag icon
          Container(
            width: 38.w,
            height: 38.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/icons/Bag 2.png',
                width: 24.w,
                height: 24.w,
                fit: BoxFit.contain,
                color: iconColor,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.shopping_bag,
                  color: iconColor,
                  size: 24.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm),

          // Date and Order Number
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  transaction.transactionDate,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                AppText(
                  transaction.orderNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),

          // Signed Price
          AppText(
            transaction.formattedAmount,
            style: AppTypography.body.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
