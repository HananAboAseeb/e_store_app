import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/shopx_logo.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Soft Blue Gradient Background Glow at Top
          Positioned(
            top: -100.h,
            left: 0,
            right: 0,
            child: Container(
              height: 400.h,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    AppColors.primary400.withOpacity(0.15),
                    AppColors.primary200.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  // Center ShopX Branding & Subtitle
                  const ShopXLogo(
                    iconSize: 110,
                    fontSize: 34,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Beautiful eCommerce UI Kit\nfor your online store',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySmall.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(flex: 3),

                  // Bottom Actions: Primary Button + Account Link
                  PrimaryButton(
                    text: 'Get Started',
                    onPressed: () {
                      context.push('/register');
                    },
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () {
                      context.push('/login');
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an Account',
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primary400,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColors.textWhite,
                              size: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
