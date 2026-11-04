import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/verified_check_badge.dart';
import '../../domain/entities/chat_order_summary_entity.dart';

class ChatOrderCard extends StatelessWidget {
  final ChatOrderSummaryEntity order;
  final VoidCallback? onSelect;
  final bool isInteractive;

  const ChatOrderCard({
    super.key,
    required this.order,
    this.onSelect,
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = order.isSelected;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 76.h,
      ),
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.chatOrderCardBg : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: isSelected
            ? null
            : Border.all(
                color: AppColors.gray200,
                width: 1.w,
              ),
        boxShadow: isSelected
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Thumbnails Section (2x2 grid for 4 items, 2 items side-by-side for 2 items)
          _buildThumbnails(order.itemCount),
          SizedBox(width: 10.w),

          // Order details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row 1: Order # + Items Count Pill
                Row(
                  children: [
                    Expanded(
                      child: AppText.body(
                        order.orderNumber,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      width: 62.w,
                      height: 21.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.chatOrderPillBg
                            : const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        '${order.itemCount} items',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),

                // Row 2: Delivery Type
                AppText.caption(
                  order.deliveryType,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF555555),
                  ),
                ),
                SizedBox(height: 6.h),

                // Row 3: Status + Action button (Selected / Select)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Status text + icon
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (order.status.toLowerCase() == 'delivered') ...[
                            Flexible(
                              child: AppText.body(
                                'Delivered',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            VerifiedCheckBadge(
                              size: 20.w,
                              backgroundColor: AppColors.primary400,
                              checkColor: AppColors.white,
                            ),
                          ] else ...[
                            Flexible(
                              child: AppText.body(
                                order.status,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(width: 6.w),

                    // Button
                    if (isInteractive) ...[
                      if (isSelected)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary400,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            'Selected',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      else
                        GestureDetector(
                          onTap: onSelect,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColors.primary400,
                                width: 1.5.w,
                              ),
                            ),
                            child: Text(
                              'Select',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary400,
                              ),
                            ),
                          ),
                        ),
                    ] else ...[
                      // In chat conversation, show Selected pill
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary400,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          'Selected',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnails(int count) {
    const defaultAssets = [
      'assets/images/home_flash_1.png',
      'assets/images/home_flash_2.png',
      'assets/images/home_flash_3.png',
      'assets/images/home_flash_4.png',
    ];

    return Container(
      width: 56.w,
      height: 56.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: count >= 4
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMiniThumb(defaultAssets[0],
                        width: 22.w, height: 22.w),
                    _buildMiniThumb(defaultAssets[1],
                        width: 22.w, height: 22.w),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMiniThumb(defaultAssets[2],
                        width: 22.w, height: 22.w),
                    _buildMiniThumb(defaultAssets[3],
                        width: 22.w, height: 22.w),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMiniThumb(defaultAssets[0], width: 22.w, height: 46.w),
                _buildMiniThumb(defaultAssets[1], width: 22.w, height: 46.w),
              ],
            ),
    );
  }

  Widget _buildMiniThumb(
    String assetPath, {
    double? width,
    double? height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: Image.asset(
        assetPath,
        width: width ?? 22.w,
        height: height ?? 22.w,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Icon(
          Icons.shopping_bag_outlined,
          size: 14.sp,
          color: AppColors.primary400,
        ),
      ),
    );
  }
}
