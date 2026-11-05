import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/payment_method_entity.dart';

class PaymentCardItem extends StatelessWidget {
  final PaymentMethodEntity card;
  final VoidCallback onTap;
  final VoidCallback? onSettingsTap;
  final double? width;
  final double? height;

  const PaymentCardItem({
    super.key,
    required this.card,
    required this.onTap,
    this.onSettingsTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isMastercard = card.cardBrand == CardBrand.mastercard;
    final backgroundColor =
        isMastercard ? AppColors.primarySoft : AppColors.blushSoft;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 230.w,
        height: height ?? 145.h,
        padding: EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top row: Brand logo and gear settings icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBrandLogo(card.cardBrand),
                GestureDetector(
                  onTap: onSettingsTap,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.settings_outlined,
                      size: 16.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),

            // Middle: Masked card number
            Text(
              card.maskedCardNumber.isNotEmpty
                  ? card.maskedCardNumber
                  : '* * * *   * * * *   * * * *   1579',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),

            // Bottom row: Cardholder name & Expiry date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.cardholderName.isNotEmpty
                      ? card.cardholderName.toUpperCase()
                      : 'AMANDA',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  card.expiryDate.isNotEmpty ? card.expiryDate : '12/22',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandLogo(CardBrand brand) {
    if (brand == CardBrand.visa) {
      return Text(
        'VISA',
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          color: AppColors.visaBlue,
          letterSpacing: 1.2,
        ),
      );
    }

    // Default to Mastercard red/orange interlocking circles
    return SizedBox(
      width: 40.w,
      height: 24.h,
      child: Stack(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: const BoxDecoration(
              color: AppColors.mastercardRed,
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            left: 14.w,
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: const BoxDecoration(
                color: AppColors.mastercardYellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
