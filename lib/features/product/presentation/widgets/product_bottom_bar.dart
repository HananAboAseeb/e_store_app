import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/primary_button.dart';

class ProductBottomBar extends StatelessWidget {
  final double currentPrice;
  final double? originalPrice;
  final bool isDiscounted;
  final VoidCallback onAddToBasket;

  const ProductBottomBar({
    super.key,
    required this.currentPrice,
    this.originalPrice,
    this.isDiscounted = false,
    required this.onAddToBasket,
  });

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 22.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.28),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.5),
                width: 1.w,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                // Pricing Column
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatPrice(currentPrice),
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (isDiscounted && originalPrice != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          _formatPrice(originalPrice!),
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFF5790),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: const Color(0xFFFF5790),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Add to Basket Button
                PrimaryButton(
                  text: 'Add to Basket',
                  width: 175.w,
                  height: 48.h,
                  onPressed: onAddToBasket,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
