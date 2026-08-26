import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class ShopXLogo extends StatelessWidget {
  final double iconWidth;
  final double iconHeight;
  final double textHeight;

  const ShopXLogo({
    super.key,
    this.iconWidth = 86.36,
    this.iconHeight = 96.0,
    this.textHeight = 34.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Exact Shopping Bag Icon from Figma (86.36 x 96)
        Image.asset(
          'assets/images/ShopX_logo.png',
          width: iconWidth.w,
          height: iconHeight.h,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(
              width: iconWidth.w,
              height: iconHeight.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary400,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  Text(
                    'S',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 16.h),

        // Exact ShopX Text Asset from Figma
        Image.asset(
          'assets/images/ShopX.png',
          height: textHeight.h,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Shop',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: 'X',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary400,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
