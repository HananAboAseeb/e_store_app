import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

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
          height: 160.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: const Color(0xFFF4B942), // Mustard Gold Accent
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Left Curved Blue Splash with Gradient
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 225.w,
                child: ClipPath(
                  clipper: _CurvedSplashClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary400,
                          AppColors.primary800,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),

              // Left Text Content: Big Sale, Up to 50%, Happening Now
              Positioned(
                left: 20.w,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "Happening Now" Tag
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'HAPPENING NOW',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // "Big Sale"
                    Text(
                      'Big Sale',
                      style: AppTypography.h1.copyWith(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textWhite,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // "Up to 50%"
                    Text(
                      'Up to 50%',
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.92),
                      ),
                    ),
                  ],
                ),
              ),

              // Right Girl Image Overlay
              Positioned(
                right: 4.w,
                bottom: 0,
                top: 0,
                child: Image.asset(
                  'assets/images/girl_image.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurvedSplashClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.72, size.height);
    path.quadraticBezierTo(
      size.width * 1.05,
      size.height * 0.5,
      size.width * 0.78,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
