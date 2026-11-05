import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';

class ProfileHeader extends StatelessWidget {
  final String avatarUrl;
  final VoidCallback? onActivityPressed;
  final VoidCallback? onScanPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSettingsPressed;
  final bool showActivityButton;
  final String? customTitle;
  final bool isScanActive;

  const ProfileHeader({
    super.key,
    required this.avatarUrl,
    this.onActivityPressed,
    this.onScanPressed,
    this.onMenuPressed,
    this.onSettingsPressed,
    this.showActivityButton = true,
    this.customTitle,
    this.isScanActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceCardImage,
            border: Border.all(
              color: AppColors.gray200,
              width: 1.w,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.person,
                color: AppColors.primary400,
                size: 22.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),

        // My Activity pill button OR custom title
        if (showActivityButton) ...[
          GestureDetector(
            onTap: onActivityPressed ??
                () => context.push(RouteNames.kMyActivityPage),
            // TODO(debug): remove before release - FIX 6: debug navigation to Rewards Center
            onLongPress: () => context.push(RouteNames.kRewardsPage),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: AppColors.primary400,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: AppText.caption(
                'My Activity',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
          const Spacer(),
        ] else if (customTitle != null) ...[
          Expanded(
            child: AppText.h2(
              customTitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                letterSpacing: -0.28,
              ),
            ),
          ),
        ] else
          const Spacer(),

        // 3 Action Buttons on the right
        _HeaderActionButton(
          assetIcon: isScanActive
              ? 'assets/images/icons/scan logo_white.png'
              : 'assets/images/icons/scan logo.png',
          isActive: isScanActive,
          onTap: onScanPressed ??
              () {
                context.push(RouteNames.kRewardsPage);
              },
        ),
        SizedBox(width: 6.w),
        _HeaderActionButton(
          assetIcon: 'assets/images/icons/top menu logo.png',
          onTap: onMenuPressed ??
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Toggled announcement variant'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
        ),
        SizedBox(width: 6.w),
        _HeaderActionButton(
          flutterIcon: Icons.settings_outlined,
          onTap: onSettingsPressed ??
              () {
                context.push(RouteNames.kSettingsPage);
              },
        ),
      ],
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  final String? assetIcon;
  final IconData? flutterIcon;
  final VoidCallback onTap;
  final bool isActive;

  const _HeaderActionButton({
    this.assetIcon,
    this.flutterIcon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary400 : AppColors.headerActionBg,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: assetIcon != null
            ? Image.asset(
                assetIcon!,
                width: 16.w,
                height: 16.w,
                color: isActive ? AppColors.textWhite : AppColors.primary400,
              )
            : Icon(
                flutterIcon,
                color: isActive ? AppColors.textWhite : AppColors.primary400,
                size: 18.sp,
              ),
      ),
    );
  }
}
