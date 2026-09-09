import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountFilterOption {
  final String label;
  final int? value;

  const DiscountFilterOption({
    required this.label,
    required this.value,
  });
}

class DiscountFilterBar extends StatelessWidget {
  final int? selectedDiscount;
  final ValueChanged<int?> onDiscountSelected;

  static const List<DiscountFilterOption> options = [
    DiscountFilterOption(label: 'All', value: null),
    DiscountFilterOption(label: '10%', value: 10),
    DiscountFilterOption(label: '20%', value: 20),
    DiscountFilterOption(label: '30%', value: 30),
    DiscountFilterOption(label: '40%', value: 40),
    DiscountFilterOption(label: '50%', value: 50),
  ];

  const DiscountFilterBar({
    super.key,
    required this.selectedDiscount,
    required this.onDiscountSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double indicatorWidth = 44.w;
    final double indicatorHeight = 35.h;
    final double pillHeight = 28.h;
    final double barHeight = 44.h;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: barHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // 1. Slender White Rounded Capsule Bar Track (Figma Container)
            Container(
              height: pillHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(pillHeight / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),

            // 2. Chips Row distributed inside the capsule bar, vertically centered
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: options.map((option) {
                final isSelected = option.value == selectedDiscount;

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onDiscountSelected(option.value),
                  child: SizedBox(
                    width: indicatorWidth,
                    height: indicatorHeight,
                    child: isSelected
                        ? CustomPaint(
                            painter: _SelectionIndicatorPainter(
                              color: const Color(0xFF004BFE),
                              strokeWidth: 3.0.w,
                            ),
                            child: Center(
                              child: Text(
                                option.label,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1A1A1A),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              option.label,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the exact Figma selection indicator:
/// Oval/ellipse (منبعجة) with unequal dimensions (wider horizontally than vertically)
/// and prominent inward-pointing triangular notches at top and bottom.
class _SelectionIndicatorPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _SelectionIndicatorPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    // 1. Fill white background so it completely masks the track behind the oval
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawOval(rect, fillPaint);

    // 2. Stroke bold royal blue oval border (منبعجة أفقياً)
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawOval(rect, strokePaint);

    // 3. Prominent top triangle notch pointing DOWN towards the center
    final notchPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double topY = strokeWidth / 2;
    const double notchH = 6.5;
    const double notchHalfW = 5.0;

    final topPath = Path();
    topPath.moveTo(centerX - notchHalfW, topY);
    topPath.lineTo(centerX + notchHalfW, topY);
    topPath.lineTo(centerX, topY + notchH);
    topPath.close();
    canvas.drawPath(topPath, notchPaint);

    // 4. Prominent bottom triangle notch pointing UP towards the center
    final double bottomY = size.height - strokeWidth / 2;
    final botPath = Path();
    botPath.moveTo(centerX - notchHalfW, bottomY);
    botPath.lineTo(centerX + notchHalfW, bottomY);
    botPath.lineTo(centerX, bottomY - notchH);
    botPath.close();
    canvas.drawPath(botPath, notchPaint);
  }

  @override
  bool shouldRepaint(covariant _SelectionIndicatorPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
