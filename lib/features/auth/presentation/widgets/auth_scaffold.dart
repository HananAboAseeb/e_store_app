import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import 'auth_page_background.dart';

class AuthScaffold extends StatelessWidget {
  final String? backgroundImage;
  final double? backgroundHeight;
  final Widget child;
  final bool showBackButton;
  final VoidCallback? onBack;
  final bool resizeToAvoidBottomInset;
  final EdgeInsetsGeometry? padding;

  const AuthScaffold({
    super.key,
    this.backgroundImage,
    this.backgroundHeight,
    required this.child,
    this.showBackButton = false,
    this.onBack,
    this.resizeToAvoidBottomInset = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: Stack(
          children: [
            // Background image asset if provided
            if (backgroundImage != null)
              AuthPageBackground(
                imagePath: backgroundImage!,
                height: backgroundHeight,
              ),

            // Screen content in SafeArea
            SafeArea(
              child: Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    if (showBackButton) ...[
                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: onBack ?? () => context.pop(),
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            color: Colors.transparent,
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.textPrimary,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                    Expanded(child: child),
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
