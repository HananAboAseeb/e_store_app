import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/primary_button.dart';

class DeliveryFailedSheet extends StatelessWidget {
  final VoidCallback? onChatNowTap;

  const DeliveryFailedSheet({
    super.key,
    this.onChatNowTap,
  });

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onChatNowTap,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.black.withOpacity(0.15),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: const SizedBox.expand(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: DeliveryFailedSheet(onChatNowTap: onChatNowTap),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Delivery was failed + Close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery was failed',
                style: AppTypography.h2.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceOption,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Subtitle: What should I do?
          Text(
            'What should I do?',
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 10.h),

          // Body text
          Text(
            "Don't worry, we will shortly contact you to arrange more suitable time for the delivery. You can also contact us by using this number +00 000 000 000 or chat with our customer care service",
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13.sp,
              height: 1.5,
            ),
          ),

          SizedBox(height: 24.h),

          // Primary Button: Chat Now (reusing PrimaryButton)
          PrimaryButton(
            text: 'Chat Now',
            onPressed: () {
              Navigator.of(context).pop();
              if (onChatNowTap != null) {
                onChatNowTap!();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Connecting to Customer Care...'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              }
            },
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
