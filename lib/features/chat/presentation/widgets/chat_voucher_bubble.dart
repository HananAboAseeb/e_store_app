import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../profile/domain/entities/voucher_entity.dart';

class ChatVoucherBubble extends StatelessWidget {
  final VoucherEntity voucher;
  final String timestamp;
  final bool showTimestamp;

  const ChatVoucherBubble({
    super.key,
    required this.voucher,
    required this.timestamp,
    this.showTimestamp = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 221.w,
              height: 81.h,
              child: CustomPaint(
                painter: _ChatTicketPainter(
                  borderColor: const Color(0xFF004CFF),
                  backgroundColor: AppColors.white,
                  notchY: 28.h,
                  notchRadius: 6.w,
                  cornerRadius: 16.r,
                  borderWidth: 2.w,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      // Top Row above dashed line
                      SizedBox(
                        height: 28.h,
                        child: Row(
                          children: [
                            AppText.caption(
                              'Voucher',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF004CFF),
                              ),
                            ),
                            const Spacer(),
                            AppText.caption(
                              'Valid Until ${voucher.validUntil}',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.voucherValidDate,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Bottom Row below dashed line
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icons/Discount.png',
                              width: 20.w,
                              height: 20.w,
                              color: const Color(0xFF004CFF),
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.verified,
                                color: const Color(0xFF004CFF),
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: AppText.body(
                                  voucher.title,
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (showTimestamp && timestamp.isNotEmpty) ...[
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: AppText.caption(
                  timestamp,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChatTicketPainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  final double notchY;
  final double notchRadius;
  final double cornerRadius;
  final double borderWidth;

  _ChatTicketPainter({
    required this.borderColor,
    required this.backgroundColor,
    required this.notchY,
    required this.notchRadius,
    required this.cornerRadius,
    required this.borderWidth,
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
      ..strokeWidth = borderWidth;

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

    // Soft drop shadow
    canvas.drawShadow(path, Colors.black.withOpacity(0.06), 4.0, false);

    // Background fill & border stroke
    canvas.drawPath(path, bgPaint);
    canvas.drawPath(path, borderPaint);

    // Dashed divider line across the notches
    final dashPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2.w;

    const dashWidth = 3.5;
    const dashSpace = 3.5;
    double startX = notchRadius + 3;
    final endX = w - notchRadius - 3;

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
  bool shouldRepaint(covariant _ChatTicketPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.notchY != notchY ||
        oldDelegate.borderWidth != borderWidth;
  }
}
