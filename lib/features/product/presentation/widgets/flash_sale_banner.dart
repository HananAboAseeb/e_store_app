import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class FlashSaleBanner extends StatelessWidget {
  final double salePrice;
  final double originalPrice;
  final int discountPercent;
  final int remainingSeconds;

  const FlashSaleBanner({
    super.key,
    required this.salePrice,
    required this.originalPrice,
    required this.discountPercent,
    required this.remainingSeconds,
  });

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    final hours = (remainingSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes =
        ((remainingSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3838),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Price + strikethrough & discount badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatPrice(salePrice),
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Text(
                    _formatPrice(originalPrice),
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white.withOpacity(0.65),
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.white.withOpacity(0.65),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      '-$discountPercent%',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF3838),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Right: Stopwatch icon + Countdown darker red boxes (00 36 58)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer_outlined,
                size: 20.sp,
                color: AppColors.white,
              ),
              SizedBox(width: 8.w),
              _buildTimeBox(hours),
              SizedBox(width: 5.w),
              _buildTimeBox(minutes),
              SizedBox(width: 5.w),
              _buildTimeBox(seconds),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String value) {
    return Container(
      width: 32.w,
      height: 28.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFC72828),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
    );
  }
}
