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
      child: Container(
        width: 112.w,
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Image Box with gray background & Darken blend mode
            Container(
              width: double.infinity,
              height: 112.h,
              decoration: BoxDecoration(
                color: grayBg,
                borderRadius: BorderRadius.circular(14.r),
              ),
              padding: EdgeInsets.all(6.w),
              child: Image.asset(
                product.imageUrl,
                color: grayBg,
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
            SizedBox(height: 8.h),

            // Bottom Unified Meta Row (Inside Card: Likes Count + Blue Heart + Tag)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${product.likeCount ?? 1780}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.favorite_rounded,
                        size: 14.sp,
                        color: const Color(0xFF004BFE),
                      ),
                    ],
                  ),
                  if (product.tag != null)
                    Text(
                      product.tag!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
