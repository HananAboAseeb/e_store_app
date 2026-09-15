import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class FilterSizeSection extends StatelessWidget {
  final String sizeType;
  final String? selectedSize;
  final ValueChanged<String>? onSizeTypeChanged;
  final ValueChanged<String?>? onSizeSelected;

  const FilterSizeSection({
    super.key,
    required this.sizeType,
    this.selectedSize,
    this.onSizeTypeChanged,
    this.onSizeSelected,
  });

  static const List<String> clothesSizes = ['XS', 'S', 'M', 'L', 'XL', '2XL'];
  static const List<String> shoesSizes = [
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42'
  ];

  @override
  Widget build(BuildContext context) {
    final sizes = sizeType == 'Shoes' ? shoesSizes : clothesSizes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Segmented Switcher [ Clothes | Shoes ]
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEBECEF),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSegmentPill('Clothes'),
                  _buildSegmentPill('Shoes'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),

        // Horizontal Size Strip
        Container(
          width: double.infinity,
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            color: const Color(0xFFDCE8FE),
            borderRadius: BorderRadius.circular(22.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: sizes.map((size) {
              final isSelected = selectedSize == size;
              return GestureDetector(
                onTap: () => onSizeSelected?.call(isSelected ? null : size),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 44.w,
                  height: 38.h,
                  child: isSelected
                      ? CustomPaint(
                          painter: _SizeSelectionIndicatorPainter(
                            color: const Color(0xFF004BFE),
                            strokeWidth: 2.5.w,
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentPill(String type) {
    final isActive = sizeType == type;
    return GestureDetector(
      onTap: () => onSizeTypeChanged?.call(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF004BFE) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF1A1A1A),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the exact Figma selection indicator:
/// Oval with white background, blue stroke border, and top/bottom triangular notches pointing inward.
class _SizeSelectionIndicatorPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _SizeSelectionIndicatorPainter({
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

    // 1. Fill white background so it masks the track behind the oval
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawOval(rect, fillPaint);

    // 2. Stroke royal blue oval border
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawOval(rect, strokePaint);

    // 3. Top triangle notch pointing DOWN towards center
    final notchPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double topY = strokeWidth / 2;
    const double notchH = 6.0;
    const double notchHalfW = 4.5;

    final topPath = Path();
    topPath.moveTo(centerX - notchHalfW, topY);
    topPath.lineTo(centerX + notchHalfW, topY);
    topPath.lineTo(centerX, topY + notchH);
    topPath.close();
    canvas.drawPath(topPath, notchPaint);

    // 4. Bottom triangle notch pointing UP towards center
    final double bottomY = size.height - strokeWidth / 2;
    final botPath = Path();
    botPath.moveTo(centerX - notchHalfW, bottomY);
    botPath.lineTo(centerX + notchHalfW, bottomY);
    botPath.lineTo(centerX, bottomY - notchH);
    botPath.close();
    canvas.drawPath(botPath, notchPaint);
  }

  @override
  bool shouldRepaint(covariant _SizeSelectionIndicatorPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
