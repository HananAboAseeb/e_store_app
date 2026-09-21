import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/home_data_entity.dart';

class ProductCardStandard extends StatelessWidget {
  final HomeProductEntity product;
  final double? width;
  final double? imageHeight;
  final VoidCallback? onTap;
  final bool showNewBadge;

  const ProductCardStandard({
    super.key,
    required this.product,
    this.width,
    this.imageHeight,
    this.onTap,
    this.showNewBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? 160.w;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // White Rounded Image Card with Shadow matching Figma
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: AspectRatio(
                  aspectRatio: 1.05,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // Title
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF333333),
                height: 1.25,
              ),
            ),
            SizedBox(height: 4.h),

            // Price formatted as $17,00
            Text(
              '\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
