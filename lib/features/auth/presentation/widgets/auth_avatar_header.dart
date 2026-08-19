import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AuthAvatarHeader extends StatelessWidget {
  final String? imageAsset;
  final String title;
  final String? subtitle;
  final double avatarSize;

  const AuthAvatarHeader({
    super.key,
    this.imageAsset = 'assets/images/profile_picture.png',
    required this.title,
    this.subtitle,
    this.avatarSize = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Pink circle with avatar image matching Figma
        Container(
          width: avatarSize.w,
          height: avatarSize.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFB2D9),
            border: Border.all(color: Colors.white, width: 3.5.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16.r,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipOval(
            child: imageAsset != null
                ? Image.asset(
                    imageAsset!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: (avatarSize * 0.6).sp,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: (avatarSize * 0.6).sp,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 24.h),

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.h2.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        // Subtitle
        if (subtitle != null) ...[
          SizedBox(height: 10.h),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 15.sp,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}
