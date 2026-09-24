import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/voucher_entity.dart';

class VoucherTicketCard extends StatelessWidget {
  final VoucherEntity voucher;
  final VoidCallback onApply;

  const VoucherTicketCard({
    super.key,
    required this.voucher,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final double cornerRadius = 14.r;
    final double notchRadius = 10.r;
    final double notchY = 34.h;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      child: CustomPaint(
        painter: TicketBorderPainter(
          borderColor: AppColors.primary,
          borderWidth: 1.5.w,
          fillColor: AppColors.surface,
          cornerRadius: cornerRadius,
          notchRadius: notchRadius,
          notchY: notchY,
        ),
        child: ClipPath(
          clipper: TicketShapeClipper(
            cornerRadius: cornerRadius,
            notchRadius: notchRadius,
            notchY: notchY,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Row: Voucher Label + Expiry
              SizedBox(
                height: notchY,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Voucher',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Valid Until ${voucher.validUntil}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.error,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Dashed Divider Line spanning between left and right notches
              Padding(
                padding: EdgeInsets.symmetric(horizontal: notchRadius + 4.w),
                child: SizedBox(
                  height: 1.5.h,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: DashedDividerPainter(
                      color: AppColors.primary,
                      dashWidth: 5.w,
                      dashSpace: 3.5.w,
                      strokeWidth: 1.5.h,
                    ),
                  ),
                ),
              ),

              // Bottom Row: Icon + Title/Description + Apply Button
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon
                    _buildVoucherIcon(voucher.iconType),
                    SizedBox(width: 12.w),

                    // Title + Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            voucher.title,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            voucher.description,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 11.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Apply Button
                    GestureDetector(
                      onTap: onApply,
                      child: Container(
                        width: 68.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Apply',
                          style: AppTypography.buttonText.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
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
    );
  }

  Widget _buildVoucherIcon(String iconType) {
    IconData iconData;
    if (iconType == 'careRosette') {
      iconData = Icons.verified;
    } else {
      iconData = Icons.shopping_bag;
    }

    return Icon(
      iconData,
      color: AppColors.primary,
      size: 26.sp,
    );
  }
}

class TicketBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final Color fillColor;
  final double cornerRadius;
  final double notchRadius;
  final double notchY;

  const TicketBorderPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.fillColor,
    required this.cornerRadius,
    required this.notchRadius,
    required this.notchY,
  });

  Path _getTicketPath(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final r = cornerRadius;
    final nr = notchRadius;
    final ny = notchY;

    // Top-left after corner
    path.moveTo(r, 0);
    // Top edge
    path.lineTo(w - r, 0);
    // Top-right corner
    path.arcToPoint(Offset(w, r), radius: Radius.circular(r));
    // Down to right notch
    path.lineTo(w, ny - nr);
    // Right notch curving inward into the card (to the left)
    path.arcToPoint(
      Offset(w, ny + nr),
      radius: Radius.circular(nr),
      clockwise: false,
    );
    // Down to bottom-right corner
    path.lineTo(w, h - r);
    // Bottom-right corner
    path.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
    // Bottom edge
    path.lineTo(r, h);
    // Bottom-left corner
    path.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
    // Up to left notch
    path.lineTo(0, ny + nr);
    // Left notch curving inward into the card (to the right)
    path.arcToPoint(
      Offset(0, ny - nr),
      radius: Radius.circular(nr),
      clockwise: false,
    );
    // Up to top-left corner
    path.lineTo(0, r);
    // Top-left corner
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r));
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = _getTicketPath(size);

    // 1. Fill background
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 2. Stroke border
    final strokePaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant TicketBorderPainter oldDelegate) =>
      oldDelegate.borderColor != borderColor ||
      oldDelegate.borderWidth != borderWidth ||
      oldDelegate.fillColor != fillColor ||
      oldDelegate.cornerRadius != cornerRadius ||
      oldDelegate.notchRadius != notchRadius ||
      oldDelegate.notchY != notchY;
}

class TicketShapeClipper extends CustomClipper<Path> {
  final double cornerRadius;
  final double notchRadius;
  final double notchY;

  const TicketShapeClipper({
    required this.cornerRadius,
    required this.notchRadius,
    required this.notchY,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final r = cornerRadius;
    final nr = notchRadius;
    final ny = notchY;

    path.moveTo(r, 0);
    path.lineTo(w - r, 0);
    path.arcToPoint(Offset(w, r), radius: Radius.circular(r));
    path.lineTo(w, ny - nr);
    path.arcToPoint(
      Offset(w, ny + nr),
      radius: Radius.circular(nr),
      clockwise: false,
    );
    path.lineTo(w, h - r);
    path.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
    path.lineTo(r, h);
    path.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
    path.lineTo(0, ny + nr);
    path.arcToPoint(
      Offset(0, ny - nr),
      radius: Radius.circular(nr),
      clockwise: false,
    );
    path.lineTo(0, r);
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r));
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant TicketShapeClipper oldClipper) =>
      oldClipper.cornerRadius != cornerRadius ||
      oldClipper.notchRadius != notchRadius ||
      oldClipper.notchY != notchY;
}

class DashedDividerPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  const DashedDividerPainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double currentX = 0;
    final y = size.height / 2;
    while (currentX < size.width) {
      final endX = (currentX + dashWidth).clamp(0.0, size.width);
      canvas.drawLine(Offset(currentX, y), Offset(endX, y), paint);
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant DashedDividerPainter oldDelegate) => false;
}
