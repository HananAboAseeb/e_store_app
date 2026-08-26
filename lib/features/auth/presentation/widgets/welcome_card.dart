import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/primary_button.dart';

class WelcomeCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String? description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const WelcomeCard({
    super.key,
    this.imageAsset = 'assets/images/image1.png',
    required this.title,
    this.description,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Photo with subtle pink reflection/glow beneath
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFC0D3).withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: SizedBox(
                width: double.infinity,
                height: 306.h,
                child: Container(
                  color: const Color(0xFFFFC0D3),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),

          // Text section: vertically centered in remaining white area
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  title,
                  style: AppTypography.h1.copyWith(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Description (Hello slide)
                if (description != null && description!.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: AppTypography.body.copyWith(
                        fontSize: 14.sp,
                        color: const Color(0xFF6B6B6B),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],

                // Button (Ready slide): larger font and more top spacing
                if (buttonText != null) ...[
                  SizedBox(height: 36.h),
                  PrimaryButton(
                    text: buttonText!,
                    height: 54.h,
                    textStyle: AppTypography.buttonText.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: onButtonPressed,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
