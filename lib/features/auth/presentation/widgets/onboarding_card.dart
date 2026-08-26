import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final int pageIndex;
  final int totalPages;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const OnboardingCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.pageIndex,
    required this.totalPages,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppColors.cardRadius.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.surface,
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 80.sp,
                      color: AppColors.primary400,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            style: AppTypography.h1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            style: AppTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (index) {
              final bool isActive = index == pageIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 8.h,
                width: isActive ? 24.w : 8.w,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary400 : AppColors.border,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              );
            }),
          ),
          SizedBox(height: 32.h),
          ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary400,
              minimumSize: Size(double.infinity, 56.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppColors.buttonRadius.r),
              ),
            ),
            child: Text(
              buttonText,
              style: AppTypography.buttonText,
            ),
          ),
        ],
      ),
    );
  }
}
