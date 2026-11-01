import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Custom-drawn verified checkmark badge matching Figma geometry exactly
class VerifiedCheckBadge extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Color? checkColor;

  const VerifiedCheckBadge({
    super.key,
    this.size = 20,
    this.backgroundColor,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _VerifiedCheckPainter(
          backgroundColor: backgroundColor ?? AppColors.primary,
          checkColor: checkColor ?? AppColors.white,
        ),
      ),
    );
  }
}

class _VerifiedCheckPainter extends CustomPainter {
  final Color backgroundColor;
  final Color checkColor;

  const _VerifiedCheckPainter({
    required this.backgroundColor,
    required this.checkColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw solid primary blue circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, bgPaint);

    // 2. Draw smooth rounded white checkmark matching Figma exactly
    final checkPaint = Paint()
      ..color = checkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.115
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final path = Path();
    // Start of check (left arm)
    path.moveTo(size.width * 0.30, size.height * 0.50);
    // Vertex of check (bottom)
    path.lineTo(size.width * 0.44, size.height * 0.67);
    // End of check (right arm)
    path.lineTo(size.width * 0.72, size.height * 0.35);

    canvas.drawPath(path, checkPaint);
  }

  @override
  bool shouldRepaint(covariant _VerifiedCheckPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.checkColor != checkColor;
}
