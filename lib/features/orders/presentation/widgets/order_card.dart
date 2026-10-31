import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/verified_check_badge.dart';
import '../../domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback? onTrackTap;
  final VoidCallback? onReviewTap;
  final VoidCallback? onPayTap;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTrackTap,
    this.onReviewTap,
    this.onPayTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Square Thumbnail Collage Box (78.w x 78.w)
            _buildThumbnailsBox(),

            SizedBox(width: 12.w),

            // Middle: Order #, Delivery Type, and Status
            Expanded(
              child: SizedBox(
                height: 78.w,
                child: _buildDetailsColumn(),
              ),
            ),

            SizedBox(width: 8.w),

            // Right: Count Pill and Action Button (96.w)
            SizedBox(
              height: 78.w,
              width: 96.w,
              child: _buildRightColumn(),
            ),
          ],
        ),
      ),
    );
  }

  /// Left square thumbnail collage matching Figma layout per item count
  Widget _buildThumbnailsBox() {
    return Container(
      width: 78.w,
      height: 78.w,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: _buildCollageContent(),
    );
  }

  Widget _buildCollageContent() {
    final count = order.itemCount;
    final items = order.items;

    if (count <= 1 || items.length <= 1) {
      // 1 item: full image
      final url =
          items.isNotEmpty ? items[0].imageUrl : 'assets/images/prod_20_1.png';
      return _buildSingleThumb(url, borderRadius: 10.r);
    }

    if (count == 2 || items.length == 2) {
      // 2 items: 2 vertical images side by side
      return Row(
        children: [
          Expanded(child: _buildSingleThumb(items[0].imageUrl)),
          SizedBox(width: 4.w),
          Expanded(
            child: _buildSingleThumb(
              items.length > 1 ? items[1].imageUrl : items[0].imageUrl,
            ),
          ),
        ],
      );
    }

    if (count == 3) {
      // 3 items: top 2 images, bottom 1 centered image
      return Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildSingleThumb(items[0].imageUrl)),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildSingleThumb(
                    items.length > 1 ? items[1].imageUrl : items[0].imageUrl,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 31.w,
                child: _buildSingleThumb(
                  items.length > 2 ? items[2].imageUrl : items[0].imageUrl,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (count == 4) {
      // 4 items: 2x2 grid
      return Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildSingleThumb(items[0].imageUrl)),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildSingleThumb(
                    items.length > 1 ? items[1].imageUrl : items[0].imageUrl,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildSingleThumb(
                    items.length > 2 ? items[2].imageUrl : items[0].imageUrl,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildSingleThumb(
                    items.length > 3 ? items[3].imageUrl : items[0].imageUrl,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // 5+ items: 2 on top, 1 bottom-left, +N badge bottom-right
    final remaining = count - 3;
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: _buildSingleThumb(items[0].imageUrl)),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildSingleThumb(
                  items.length > 1 ? items[1].imageUrl : items[0].imageUrl,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _buildSingleThumb(
                  items.length > 2 ? items[2].imageUrl : items[0].imageUrl,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.countPillBg,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+$remaining',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 11.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSingleThumb(String url, {double? borderRadius}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
      child: Container(
        color: AppColors.thumbnailBg,
        child: Image.asset(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildDetailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.orderNumber,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14.5.sp,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              order.deliveryType,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.5.sp,
                color: const Color(
                    0xFF4B5563), // Darker charcoal gray matching Figma
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: _buildStatusRow(),
        ),
      ],
    );
  }

  Widget _buildStatusRow() {
    switch (order.status) {
      case OrderStatus.packed:
        return Text(
          'Packed',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 14.5.sp,
            color: AppColors.textPrimary,
          ),
        );
      case OrderStatus.shipped:
        return Text(
          'Shipped',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 14.5.sp,
            color: AppColors.textPrimary,
          ),
        );
      case OrderStatus.delivered:
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Delivered',
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14.5.sp,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 6.w),
            // Custom drawn verified check badge matching Figma exactly
            VerifiedCheckBadge(size: 20.w),
          ],
        );
      case OrderStatus.failedAttempt:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Failed Attempt',
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14.5.sp,
                color: AppColors.statusFailed,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.error_outline_rounded,
              size: 16.sp,
              color: AppColors.statusFailed,
            ),
          ],
        );
      case OrderStatus.toPay:
        return Text(
          'To Pay',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 14.5.sp,
            color: AppColors.textPrimary,
          ),
        );
    }
  }

  Widget _buildRightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Top: Item Count Pill (right aligned)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.5.h),
          decoration: BoxDecoration(
            color: AppColors.countPillBg,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            '${order.itemCount} ${order.itemCount == 1 ? "item" : "items"}',
            style: AppTypography.caption.copyWith(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),

        // Bottom: Action Button (W: 96, H: 30 matching Figma inspector exactly)
        _buildActionButton(),
      ],
    );
  }

  Widget _buildActionButton() {
    switch (order.status) {
      case OrderStatus.packed:
      case OrderStatus.shipped:
      case OrderStatus.failedAttempt:
        return GestureDetector(
          onTap: onTrackTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 96.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(15.r),
            ),
            alignment: Alignment.center,
            child: Text(
              'Track',
              style: AppTypography.buttonText.copyWith(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        );
      case OrderStatus.delivered:
        return GestureDetector(
          onTap: onReviewTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 96.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: AppColors.primary,
                width: 1.5.w,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'Review',
              style: AppTypography.buttonText.copyWith(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      case OrderStatus.toPay:
        return GestureDetector(
          onTap: onPayTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 96.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(15.r),
            ),
            alignment: Alignment.center,
            child: Text(
              'Pay',
              style: AppTypography.buttonText.copyWith(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        );
    }
  }
}
