import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/home_data_entity.dart';

class PopularProductCard extends StatelessWidget {
  final HomeProductEntity product;
  final VoidCallback? onTap;

  const PopularProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const grayBg = Color(0xFFE5E6EA);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 108.w,
        padding: EdgeInsets.all(5.w),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Image Box with gray background (Figma: compact, rounded)
            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                color: grayBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(4.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
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
            SizedBox(height: 6.h),

            // Bottom Unified Meta Row (Likes Count + Blue Heart + Tag)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${product.likeCount ?? 1780}',
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF000000),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            Icons.favorite_rounded,
                            size: 12.sp,
                            color: const Color(0xFF004BFE),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (product.tag != null) ...[
                    SizedBox(width: 2.w),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          product.tag!,
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
