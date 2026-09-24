import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/cart_item_entity.dart';

/// Unified "From Your Wishlist" section used in both populated and empty cart.
/// Each item is a horizontal row: Image (with delete at bottom-left) | Title + Price + Pills | Add-to-cart icon.
class FromYourWishlistSection extends StatelessWidget {
  final List<CartItemEntity> items;
  final ValueChanged<CartItemEntity> onAddToCart;
  final ValueChanged<String> onDeleteFromWishlist;

  const FromYourWishlistSection({
    super.key,
    required this.items,
    required this.onAddToCart,
    required this.onDeleteFromWishlist,
  });

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            'From Your Wishlist',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          itemCount: items.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final item = items[index];
            return _WishlistItemRow(
              item: item,
              formattedPrice: _formatPrice(item.unitPrice),
              onAddToCart: () => onAddToCart(item),
              onDelete: () => onDeleteFromWishlist(item.id),
            );
          },
        ),
      ],
    );
  }
}

class _WishlistItemRow extends StatelessWidget {
  final CartItemEntity item;
  final String formattedPrice;
  final VoidCallback onAddToCart;
  final VoidCallback onDelete;

  const _WishlistItemRow({
    required this.item,
    required this.formattedPrice,
    required this.onAddToCart,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Delete icon at BOTTOM-LEFT
          Stack(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 28.sp,
                        color: AppColors.gray400,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4.r,
                left: 4.r,
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: const Color(0xFFFF3B30),
                      size: 13.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),

          // Middle column: Title → Price → (Pills + Cart Icon)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
                SizedBox(height: 4.h),
                // Price first (Figma order)
                Text(
                  formattedPrice,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                // Color & Size pills (004CFF 10% background) + Blue Cart Icon on the right
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary400.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        item.color,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary400.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        item.size,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Add to cart button (blue icon on white/natural background)
                    GestureDetector(
                      onTap: onAddToCart,
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        width: 28.w,
                        height: 28.w,
                        child: Center(
                          child: Image.asset(
                            'assets/images/icons/add to basket.png',
                            width: 22.w,
                            height: 22.w,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.add_shopping_cart,
                              color: AppColors.primary400,
                              size: 20.sp,
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
