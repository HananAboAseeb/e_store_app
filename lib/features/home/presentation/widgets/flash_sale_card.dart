import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/discount_badge.dart';
import '../../domain/entities/home_data_entity.dart';

class FlashSaleCard extends StatelessWidget {
  final HomeProductEntity product;
  final VoidCallback? onTap;

  const FlashSaleCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final discount = product.discountPercentage ?? 20;
    const grayBg = Color(0xFFE5E6EA);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
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
        child: Stack(
          children: [
            // Inner image with light gray background and white border/padding all around
            Padding(
              padding: EdgeInsets.all(6.w),
              child: Container(
                decoration: BoxDecoration(
                  color: grayBg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox.expand(
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),

            // Top-Right Discount Badge placed at top-right of the outer card over the border
            Positioned(
              top: 0,
              right: 0,
              child: DiscountBadge(
                discountPercentage: discount,
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
    );
  }
}
