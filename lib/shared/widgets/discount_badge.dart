import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountBadge extends StatelessWidget {
  final int discountPercentage;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  const DiscountBadge({
    super.key,
    required this.discountPercentage,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFF5790), // Figma 0%
            Color(0xFFF81140), // Figma 100%
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: borderRadius ??
            BorderRadius.only(
              topRight: Radius.circular(14.r),
              bottomLeft: Radius.circular(10.r),
              topLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF81140).withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '-$discountPercentage %',
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}
