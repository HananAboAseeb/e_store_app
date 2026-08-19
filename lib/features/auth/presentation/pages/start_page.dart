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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // Background Glow from Figma Asset
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 520.h,
                child: Image.asset(
                  'assets/images/faded_background.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: const Alignment(0, -0.4),
                          radius: 0.85,
                          colors: [
                            AppColors.primary400.withOpacity(0.18),
                            AppColors.primary100.withOpacity(0.06),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Main Screen Content
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    const Spacer(flex: 3),

                    // Center ShopX Branding (86.36 x 96 icon + exact ShopX asset)
                    const ShopXLogo(),
                    SizedBox(height: 18.h),

                    // Subtitle
                    Text(
                      'Beautiful eCommerce UI Kit\nfor your online store',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                        height: 1.35,
                      ),
                    ),

                    const Spacer(flex: 4),

                    // Get Started Primary Button
                    PrimaryButton(
                      text: 'Get Started',
                      onPressed: () {
                        context.push('/register');
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Already have an Account -> Link (Explicit LTR)
                    GestureDetector(
                      onTap: () {
                        context.push('/login');
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          textDirection: TextDirection.ltr,
                          children: [
                            Text(
                              'Already have an Account',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: const BoxDecoration(
                                color: AppColors.primary400,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: AppColors.textWhite,
                                size: 18.sp,
                                textDirection: TextDirection.ltr,
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
      ),
    );
  }
}
