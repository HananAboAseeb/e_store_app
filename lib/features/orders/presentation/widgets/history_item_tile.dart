import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
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
    // Prefer the high-fidelity Figma history product asset for history tiles
    final imageUrl = (firstItem != null && firstItem.imageUrl.isNotEmpty)
        ? firstItem.imageUrl
        : 'assets/images/history_product.png';
    final title = firstItem?.title ?? 'Lorem ipsum dolor sit amet consectetur.';
    final date = firstItem?.formattedDate.isNotEmpty == true
        ? firstItem!.formattedDate
        : 'April, 06';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Thumbnail matching Figma Screen 65 (136x108, Radius 15, with white padding frame and soft drop shadow)
          Container(
            width: 136.w,
            height: 108.h,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11.r),
              child: Container(
                color: AppColors.thumbnailBg,
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/history_product.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title (2 lines)
                Text(
                  title,
                  style: AppTypography.caption.copyWith(
                    color: const Color(0xFF4B5563),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.25,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                // Bold Order Number
                Text(
                  order.orderNumber.isNotEmpty
                      ? order.orderNumber
                      : 'Order #92287157',
                  style: AppTypography.body.copyWith(
                    color: const Color(0xFF111827),
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10.h),

                // Bottom row: Date Pill + Review Button with flexible width to eliminate right overflow on all screen sizes
                Row(
                  children: [
                    // Date Pill (H: 30, radius: 10, Color(0xFFE8ECEF))
                    Expanded(
                      flex: 48,
                      child: Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8ECEF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              date,
                              maxLines: 1,
                              style: AppTypography.caption.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 6.w),

                    // Outlined Capsule Review Button (H: 30, radius: 16 per Figma Dev Mode)
                    Expanded(
                      flex: 52,
                      child: GestureDetector(
                        onTap: onReviewTap,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: const Color(0xFF004BFE),
                              width: 1.5.w,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Text(
                                'Review',
                                maxLines: 1,
                                style: AppTypography.buttonText.copyWith(
                                  fontSize: 12.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF004BFE),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
