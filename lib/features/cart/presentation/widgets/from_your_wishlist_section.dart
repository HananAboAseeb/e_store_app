import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/product_item_row.dart';
import '../../domain/entities/cart_item_entity.dart';

/// Unified "From Your Wishlist" section used in both populated and empty cart.
/// Each item delegates its presentation to the shared [ProductItemRow].
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
            return ProductItemRow(
              imageUrl: item.imageUrl,
              title: item.title,
              price: item.unitPrice,
              color: item.color,
              size: item.size,
              onDelete: () => onDeleteFromWishlist(item.id),
              trailingAction: GestureDetector(
                onTap: () => onAddToCart(item),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(4.r),
                  child: Image.asset(
                    'assets/images/icons/add to basket.png',
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.add_shopping_cart,
                      color: AppColors.primary400,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
