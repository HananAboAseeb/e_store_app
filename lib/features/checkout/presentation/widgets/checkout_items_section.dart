import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/order_item_entity.dart';
import '../../domain/entities/voucher_entity.dart';
import 'checkout_item_card.dart';

class CheckoutItemsSection extends StatelessWidget {
  final List<OrderItemEntity> items;
  final VoucherEntity? appliedVoucher;
  final VoidCallback onAddVoucher;
  final VoidCallback? onRemoveVoucher;

  const CheckoutItemsSection({
    super.key,
    required this.items,
    this.appliedVoucher,
    required this.onAddVoucher,
    this.onRemoveVoucher,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = items.fold(0, (sum, i) => sum + i.quantity);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Items',
                  style: AppTypography.h2.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 26.h,
                  height: 26.h,
                  decoration: const BoxDecoration(
                    color: AppColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$itemCount',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: AppColors.primary900,
                    ),
                  ),
                ),
              ],
            ),

            // Action Button: "Add Voucher" outlined pill OR applied discount badge
            if (appliedVoucher == null)
              GestureDetector(
                onTap: onAddVoucher,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.5.w,
                    ),
                  ),
                  child: Text(
                    'Add Voucher',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 7.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${appliedVoucher!.discountPercentage.toInt()}% Discount',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    GestureDetector(
                      onTap: onRemoveVoucher,
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: AppSpacing.xs),

        // Items List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => SizedBox(height: 2.h),
          itemBuilder: (context, index) => CheckoutItemCard(item: items[index]),
        ),
      ],
    );
  }
}
