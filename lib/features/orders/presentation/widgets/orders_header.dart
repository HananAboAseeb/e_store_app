import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class OrdersHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onMessageTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onBackTap;
  final bool showBackButton;

  const OrdersHeader({
    super.key,
    this.title = 'To Recieve',
    this.subtitle = 'My Orders',
    this.onMessageTap,
    this.onFilterTap,
    this.onSettingsTap,
    this.onBackTap,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBackButton) ...[
              GestureDetector(
                onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: const BoxDecoration(
                    color: AppColors.headerActionBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ] else ...[
              // User Avatar with light blue border ring
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primarySoft,
                    width: 1.5.w,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile_picture.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],

            // Titles: Generous, pleasant vertical hierarchy matching Figma
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTypography.h2.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                      color: AppColors.textPrimary,
                      height: 1.05,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle.isNotEmpty) ...[
                    SizedBox(height: 1.h),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(
                        color: const Color(
                            0xFF1F2937), // Darker charcoal per Figma and user feedback
                        fontSize: 13.sp, // Raleway SemiBold in Figma
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.14,
                        height: 1.05,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // 3 Utility Action Icons using the exact assets added by the user
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Scan logo icon
                _buildAssetActionIcon(
                  assetPath: 'assets/images/icons/scan logo.png',
                  width: 18.w,
                  height: 18.w,
                  onTap: onMessageTap,
                ),
                SizedBox(width: 9.w),

                // 2. Top menu logo icon
                _buildAssetActionIcon(
                  assetPath: 'assets/images/icons/top menu logo.png',
                  width: 17.w,
                  height: 13.w,
                  onTap: onFilterTap,
                ),
                SizedBox(width: 9.w),

                // 3. Settings icon
                _buildActionIcon(
                  icon: Icons.settings_outlined,
                  onTap: onSettingsTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetActionIcon({
    required String assetPath,
    required double width,
    required double height,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 35.w,
        height: 35.w,
        decoration: const BoxDecoration(
          color: AppColors.headerActionBg,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Image.asset(
          assetPath,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 35.w,
        height: 35.w,
        decoration: const BoxDecoration(
          color: AppColors.headerActionBg,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 19.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
