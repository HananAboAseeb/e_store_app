import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/voucher_entity.dart';

class VoucherCard extends StatelessWidget {
  final VoucherEntity voucher;
  final VoidCallback? onTap;

  const VoucherCard({
    super.key,
    required this.voucher,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isExpiring = voucher.isExpiring;
    final borderColor =
        isExpiring ? AppColors.voucherWarning : AppColors.primary400;
    final bgColor = isExpiring ? AppColors.voucherWarningBg : AppColors.white;
    final voucherLabelColor =
        isExpiring ? AppColors.voucherWarning : AppColors.primary400;
    final dateLabelColor =
        isExpiring ? AppColors.voucherWarning : AppColors.voucherValidDate;
    final dateText = isExpiring
        ? '${voucher.daysLeft} days left'
        : 'Valid Until ${voucher.validUntil}';

    return GestureDetector(
      onTap: onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Voucher "${voucher.title}" selected'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
      child: CustomPaint(
        painter: _TicketPainter(
          borderColor: borderColor,
          backgroundColor: bgColor,
          notchY: 34.h,
          notchRadius: 8.w,
          cornerRadius: 16.r,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Row above dashed line
              Row(
                children: [
                  AppText.caption(
                    'Voucher',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: voucherLabelColor,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppText.caption(
                      dateText,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: dateLabelColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h), // Space across the dashed line

              // Bottom Row below dashed line
              Row(
                children: [
                  // Icon
                  _buildIcon(voucher.iconType),
                  SizedBox(width: AppSpacing.sm),

                  // Title & Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.h3(
                          voucher.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        AppText.caption(
                          voucher.subtitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String iconType) {
    if (iconType == 'badge') {
      return Image.asset(
        'assets/images/icons/Discount.png',
        width: 26.w,
        height: 26.w,
        color: AppColors.primary400,
        errorBuilder: (_, __, ___) => Icon(
          Icons.verified,
          color: AppColors.primary400,
          size: 26.sp,
        ),
      );
    }

    if (iconType == 'bag') {
      return Image.asset(
        'assets/images/ShopX_logo.png',
        width: 24.w,
        height: 24.w,
        color: AppColors.primary400,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(
          Icons.shopping_bag,
          color: AppColors.primary400,
          size: 24.sp,
        ),
      );
    }

    final IconData iconData = switch (iconType) {
      'heart' => Icons.favorite,
      _ => Icons.shopping_bag,
    };

    return SizedBox(
      width: 26.w,
      height: 26.w,
      child: Center(
        child: Icon(
          iconData,
          color: AppColors.primary400,
          size: 26.sp,
        ),
      ),
    );
  }
}

class _TicketPainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  final double notchY;
  final double notchRadius;
  final double cornerRadius;

  _TicketPainter({
    required this.borderColor,
    required this.backgroundColor,
    required this.notchY,
    required this.notchRadius,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5.w;

    final path = Path();
    path.moveTo(cornerRadius, 0);

    // Top edge
    path.lineTo(w - cornerRadius, 0);
    path.arcToPoint(
      Offset(w, cornerRadius),
      radius: Radius.circular(cornerRadius),
    );

    // Right edge down to notch
    path.lineTo(w, notchY - notchRadius);
    path.arcToPoint(
      Offset(w, notchY + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Right edge below notch
    path.lineTo(w, h - cornerRadius);
    path.arcToPoint(
      Offset(w - cornerRadius, h),
      radius: Radius.circular(cornerRadius),
    );

    // Bottom edge
    path.lineTo(cornerRadius, h);
    path.arcToPoint(
      Offset(0, h - cornerRadius),
      radius: Radius.circular(cornerRadius),
    );

    // Left edge below notch
    path.lineTo(0, notchY + notchRadius);
    path.arcToPoint(
      Offset(0, notchY - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Left edge above notch
    path.lineTo(0, cornerRadius);
    path.arcToPoint(
      Offset(cornerRadius, 0),
      radius: Radius.circular(cornerRadius),
    );

    path.close();

    // Draw background and outline border
    canvas.drawPath(path, bgPaint);
    canvas.drawPath(path, borderPaint);

    // Draw dashed line across the notches
    final dashPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2.w;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = notchRadius + 4;
    final endX = w - notchRadius - 4;

    while (startX < endX) {
      canvas.drawLine(
        Offset(startX, notchY),
        Offset(startX + dashWidth, notchY),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _TicketPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.notchY != notchY;
  }
}
