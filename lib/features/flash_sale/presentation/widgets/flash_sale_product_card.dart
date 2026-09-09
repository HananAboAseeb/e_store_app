import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/discount_badge.dart';
import '../../domain/entities/flash_sale_product_entity.dart';

class FlashSaleProductCard extends StatelessWidget {
  final FlashSaleProductEntity product;
  final VoidCallback? onTap;

  const FlashSaleProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. White Rounded Card containing the Product Image with full white border + Discount Badge over the border (Figma)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: [
                  // Padded image container so white border surrounds the image on all sides
                  Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E6EA),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox.expand(
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: const Color(0xFFF0F1F5),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Top-Right Discount Badge placed at the top-right corner of the whole white card (over the border)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: DiscountBadge(
                      discountPercentage: product.discountPercentage,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(12.r),
                        topLeft: Radius.circular(6.r),
                        bottomRight: Radius.circular(6.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // 2. Product Title (Outside the card container, max 2 lines)
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A1A1A),
              height: 1.25,
            ),
          ),
          SizedBox(height: 4.h),

          // 3. Price Row: New Bold Price + Strikethrough Pink/Red Old Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$${product.currentPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A1A),
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                '\$${product.originalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFFF5271),
                  decoration: TextDecoration.lineThrough,
                  decorationColor: const Color(0xFFFF5271),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
