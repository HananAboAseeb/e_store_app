import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/shop_product_entity.dart';

class ShopProductCard extends StatelessWidget {
  final ShopProductEntity product;
  final VoidCallback? onTap;

  const ShopProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFF5F5F5),
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 40.sp,
                        color: AppColors.gray400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // Product Title
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.25,
            ),
          ),
          SizedBox(height: 4.h),
          // Price Row
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  _formatPrice(product.price),
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (product.isDiscounted && product.originalPrice != null) ...[
                  SizedBox(width: 8.w),
                  Text(
                    _formatPrice(product.originalPrice!),
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFF5790),
                      decoration: TextDecoration.lineThrough,
                      decorationColor: const Color(0xFFFF5790),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}
