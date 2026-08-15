import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class ShopXLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;

  const ShopXLogo({
    super.key,
    this.iconSize = 100.0,
    this.fontSize = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Shopping Bag Icon
        SizedBox(
          width: iconSize.w,
          height: (iconSize * 1.1).h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bag Body + Handle Custom Painter
              CustomPaint(
                size: Size(iconSize.w, (iconSize * 1.1).h),
                painter: _ShoppingBagPainter(),
              ),
              // White "S" on the bag
              Positioned(
                bottom: 22.h,
                child: Text(
                  'S',
                  style: TextStyle(
                    fontSize: (fontSize * 0.95).sp,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textWhite,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // "ShopX" Typography
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Shop',
                style: TextStyle(
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'X',
                style: TextStyle(
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary400,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShoppingBagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    // Gradient Paint for Bag Body
    final Paint bagPaint = Paint()
      ..shader = const LinearGradient(
          colors: [
            Color(0xFF003AC1),
            Color(0xFF004BFE),
            Color(0xFF2968FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, width, height))
      ..style = PaintingStyle.fill;

    // Handle Paint (outer loop)
    final Paint handlePaint = Paint()
      ..color = const Color(0xFF003AC1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * 0.12
      ..strokeCap = StrokeCap.round;

    // Draw Handle Loop at top
    final Path handlePath = Path();
    final double handleRadius = width * 0.22;
    final Offset handleCenter = Offset(width / 2, height * 0.32);
    handlePath.addArc(
      Rect.fromCircle(center: handleCenter, radius: handleRadius),
      3.14,
      3.14,
    );
    canvas.drawPath(handlePath, handlePaint);

    // Draw Bag Body
    final Path bagPath = Path();
    final double topMargin = height * 0.28;
    final double radius = width * 0.18;

    bagPath.moveTo(width * 0.15, topMargin);
    bagPath.lineTo(width * 0.85, topMargin);
    bagPath.quadraticBezierTo(width * 0.95, topMargin, width * 0.92, topMargin + radius);
    bagPath.lineTo(width * 0.85, height - radius);
    bagPath.quadraticBezierTo(width * 0.82, height, width * 0.82 - radius, height);
    bagPath.lineTo(width * 0.18 + radius, height);
    bagPath.quadraticBezierTo(width * 0.18, height, width * 0.15, height - radius);
    bagPath.lineTo(width * 0.08, topMargin + radius);
    bagPath.quadraticBezierTo(width * 0.05, topMargin, width * 0.15, topMargin);
    bagPath.close();

    canvas.drawPath(bagPath, bagPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
