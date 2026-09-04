import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/home_data_entity.dart';

class TopProductsBar extends StatelessWidget {
  final List<HomeProductEntity> products;
  final ValueChanged<HomeProductEntity>? onProductTap;

  const TopProductsBar({
    super.key,
    required this.products,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    const grayBg = Color(0xFFE5E6EA);

    return SizedBox(
      height: 72.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => onProductTap?.call(product),
            child: Container(
              width: 68.w,
              height: 68.h,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: grayBg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.all(4.w),
                child: Image.asset(
                  product.imageUrl,
                  color: grayBg,
                  colorBlendMode: BlendMode.darken,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
