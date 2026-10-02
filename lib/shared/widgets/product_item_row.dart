import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import 'meta_pill.dart';

/// Reusable horizontal product card row used across Cart (Screen 44) and Wishlist (Screen 38).
///
/// Features:
/// - 90.w x 90.w rounded product image (12.r)
/// - Circular white delete button at bottom-left of the image
/// - 2-line title with ellipsis
/// - Meta pills (Pink + M)
/// - Bold price formatting
/// - Customizable trailing action widget (e.g. QuantityControl or AddToCart button)
class ProductItemRow extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String? color;
  final String? size;
  final Widget? attributesWidget;
  final VoidCallback onDelete;
  final Widget trailingAction;
  final VoidCallback? onTap;
  final bool isWishlistLayout;

  const ProductItemRow({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.color,
    this.size,
    this.attributesWidget,
    required this.onDelete,
    required this.trailingAction,
    this.onTap,
    this.isWishlistLayout = true,
  });

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: isWishlistLayout ? 8.h : 6.h,
        ),
        padding: isWishlistLayout ? EdgeInsets.zero : EdgeInsets.all(12.r),
        decoration: isWishlistLayout
            ? const BoxDecoration(color: AppColors.white)
            : BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Image (144x114 for Wishlist, 90x90 for Cart)
            Stack(
              children: [
                Container(
                  width: isWishlistLayout ? 144.w : 90.w,
                  height: isWishlistLayout ? 114.h : 90.w,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCardImage,
                    borderRadius: BorderRadius.circular(
                      isWishlistLayout ? 15.r : 12.r,
                    ),
                    border: isWishlistLayout
                        ? Border.all(
                            color: AppColors.white,
                            width: 3.w,
                          )
                        : null,
                    boxShadow: isWishlistLayout
                        ? [
                            BoxShadow(
                              color: AppColors.cardShadow,
                              blurRadius: 12.r,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      isWishlistLayout ? 12.r : 12.r,
                    ),
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 32.sp,
                          color: AppColors.gray400,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: isWishlistLayout ? 6.r : 4.r,
                  left: isWishlistLayout ? 6.r : 4.r,
                  child: GestureDetector(
                    onTap: onDelete,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: isWishlistLayout ? 26.w : 24.w,
                      height: isWishlistLayout ? 26.w : 24.w,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: AppColors.error,
                        size: isWishlistLayout ? 16.sp : 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: isWishlistLayout ? 14.w : 12.w),

            // Middle & Right Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  if (isWishlistLayout) ...[
                    // Wishlist layout: Price then Pills + AddToCart row
                    Text(
                      _formatPrice(price),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (attributesWidget != null)
                          attributesWidget!
                        else if (color != null && size != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MetaPill(text: color!),
                              SizedBox(width: 8.w),
                              MetaPill(text: size!),
                            ],
                          )
                        else
                          const SizedBox.shrink(),
                        trailingAction,
                      ],
                    ),
                  ] else ...[
                    // Cart layout: Size & Color row then Price + Quantity row
                    if (attributesWidget != null)
                      attributesWidget!
                    else if (color != null && size != null)
                      Row(
                        children: [
                          MetaPill(text: size!),
                          SizedBox(width: 8.w),
                          MetaPill(text: color!),
                        ],
                      ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatPrice(price),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        trailingAction,
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
