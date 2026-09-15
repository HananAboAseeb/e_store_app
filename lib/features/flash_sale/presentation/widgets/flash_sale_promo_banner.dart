import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlashSalePromoBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const FlashSalePromoBanner({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 135.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image: Yellow background with model holding SALE bag and blue shapes
              Image.asset(
                'assets/images/big_sale_banner.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/Big_Sale_Banner (2).png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: const Color(0xFFF4B942)),
                ),
              ),

              // Left Text Layout: "Big Sale" & "Up to 50%"
              Positioned(
                left: 18.w,
                top: 14.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Big Sale',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A1A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Up to 50%',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF262626),
                      ),
                    ),
                  ],
                ),
              ),

              // "Happening\nNow" positioned inside the blue bottom-left curve (Figma)
              Positioned(
                left: 18.w,
                bottom: 12.h,
                child: Text(
                  'Happening\nNow',
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
