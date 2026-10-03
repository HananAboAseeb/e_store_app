import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/meta_pill.dart';
import '../../domain/entities/order_entity.dart';

class HistoryItemTile extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback? onReviewTap;

  const HistoryItemTile({
    super.key,
    required this.order,
    this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    final firstItem = order.items.isNotEmpty ? order.items.first : null;
    final imageUrl = firstItem?.imageUrl ?? 'assets/images/prod_20_1.png';
    final title = firstItem?.title ?? 'Lorem ipsum dolor sit amet consectetur.';
    final date = firstItem?.formattedDate.isNotEmpty == true
        ? firstItem!.formattedDate
        : 'April, 06';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Thumbnail
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: AppColors.surfaceCardImage,
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      order.orderNumber,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    MetaPill(
                      text: date,
                      backgroundColor: AppColors.surfaceOption,
                      textColor: AppColors.textSecondary,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Outlined Review Button
          SizedBox(
            width: 80.w,
            height: 34.h,
            child: OutlinedButton(
              onPressed: onReviewTap,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Review',
                style: AppTypography.buttonText.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
