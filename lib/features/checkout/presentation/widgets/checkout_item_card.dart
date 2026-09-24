import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/order_item_entity.dart';

class CheckoutItemCard extends StatelessWidget {
  final OrderItemEntity item;

  const CheckoutItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 72.w,
              height: 72.w,
              color: AppColors.gray100,
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.shopping_bag_outlined,
                  size: 32.sp,
                  color: AppColors.gray400,
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),

                // Meta pills: Quantity Circle + Color Pill + Size Pill
                Row(
                  children: [
                    // Quantity Circle Badge
                    Container(
                      width: 22.h,
                      height: 22.h,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${item.quantity}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Color Pill
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        item.color,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),

                    // Size Pill
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        item.size,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.sm),

          // Price
          Text(
            '\$${item.unitPrice.toStringAsFixed(2).replaceAll('.', ',')}',
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
