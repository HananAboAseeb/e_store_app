import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/voucher_entity.dart';
import 'voucher_ticket_card.dart';

class VoucherBottomSheet extends StatelessWidget {
  final List<VoucherEntity> vouchers;
  final ValueChanged<String> onApplyVoucher;
  final VoidCallback? onClose;

  const VoucherBottomSheet({
    super.key,
    required this.vouchers,
    required this.onApplyVoucher,
    this.onClose,
  });

  static Future<void> show({
    required BuildContext context,
    required List<VoucherEntity> vouchers,
    required ValueChanged<String> onApplyVoucher,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.08),
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
              child: VoucherBottomSheet(
                vouchers: vouchers,
                onApplyVoucher: onApplyVoucher,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleClose(BuildContext context) {
    if (onClose != null) {
      onClose!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 16.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Title + Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Active Vouchers',
                    style: AppTypography.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _handleClose(context),
                  child: Container(
                    width: 36.h,
                    height: 36.h,
                    decoration: const BoxDecoration(
                      color: AppColors.gray100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 20.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),

            // Vouchers List
            ...vouchers.map(
              (voucher) => VoucherTicketCard(
                voucher: voucher,
                onApply: () {
                  onApplyVoucher(voucher.id);
                  _handleClose(context);
                },
              ),
            ),
            SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
