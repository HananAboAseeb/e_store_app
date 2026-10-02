import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/product_item_row.dart';
import '../../domain/entities/wishlist_item_entity.dart';

/// Wishlist item row wrapping the shared [ProductItemRow] with meta pills and an add-to-cart action button.
class WishlistItemRow extends StatelessWidget {
  final WishlistItemEntity item;
  final VoidCallback onDelete;
  final VoidCallback onAddToCart;
  final VoidCallback? onTap;

  const WishlistItemRow({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onAddToCart,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProductItemRow(
      imageUrl: item.imageUrl,
      title: item.title,
      price: item.price,
      color: item.color,
      size: item.size,
      onDelete: onDelete,
      onTap: onTap,
      trailingAction: GestureDetector(
        onTap: onAddToCart,
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
  }
}
