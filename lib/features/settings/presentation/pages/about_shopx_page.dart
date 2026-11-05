import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';

class AboutShopXPage extends StatelessWidget {
  const AboutShopXPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ── Background Glow & ShopX Illustration ───────────────────
            Image.asset(
              'assets/images/background/shopx.png',
              width: 1.sw,
              height: 462.h,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),

            // ── Page Content ───────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 357.h),

                  // Title
                  AppText(
                    'About ShopX',
                    style: AppTypography.h1.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),

                  // UI Kit Description
                  AppText(
                    'ShopX - Shopping UI kit is a user interface (UI) kit designed to facilitate the development of e-commerce or shopping-related applications. UI kits are collections of pre-designed elements, components, and templates that developers and designers can use to create consistent and visually appealing user interfaces.',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.5,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl),

                  // Help prompt
                  AppText(
                    'If you need help or you have any questions, feel free to contact me by email.',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.5,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),

                  // Contact Email
                  AppText(
                    'contact.blacksidedesign@gmail.com',
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
