import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/modal_close_button.dart';

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
      barrierColor: AppColors.transparent,
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.opaque,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(color: AppColors.black.withOpacity(0.15)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DeliveryFailedSheet(onChatNowTap: onChatNowTap),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 76.h),
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
                style: AppTypography.modalTitle,
              ),
              const ModalCloseButton(),
            ],
          ),

          SizedBox(height: 14.h),

          // Subtitle: What should I do? (Figma: Raleway Bold 18, height: 24, #090909)
          Text(
            'What should I do?',
            style: AppTypography.modalSubtitle,
          ),

          SizedBox(height: 10.h),

          // Body text (Figma: Nunito Sans, height: 20, 0px spacing)
          Text(
            "Don't worry, we will shortly contact you to arrange more suitable time for the delivery. You can also contact us by using this number +00 000 000 000 or chat with our customer care service",
            style: AppTypography.modalBody,
          ),

          SizedBox(height: 24.h),

          // Primary Button: Chat Now (W: 335, H: 48, Radius: 24 matching Figma)
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'Chat Now',
                style: AppTypography.buttonText.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
