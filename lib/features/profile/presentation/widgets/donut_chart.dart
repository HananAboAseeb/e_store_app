import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/category_spending_entity.dart';

class DonutChart extends StatelessWidget {
  final double totalAmount;
  final List<CategorySpendingEntity> categories;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const DonutChart({
    super.key,
    required this.totalAmount,
    required this.categories,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Arrow Button
        _ArrowButton(
          icon: Icons.arrow_back,
          onTap: onPreviousMonth,
        ),

        // Donut Chart Container (Figma: 228x228 with white circular card and shadow)
        Container(
          width: 228.w,
          height: 228.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(228.w, 228.w),
                painter: _DonutChartPainter(
                  totalAmount: totalAmount,
                  categories: categories,
                ),
              ),
              // Center Labels using Design System AppText (FIX 5)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.bodySecondary(
                    'Total',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  AppText.price(
                    '\$${totalAmount.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Right Arrow Button
        _ArrowButton(
          icon: Icons.arrow_forward,
          onTap: onNextMonth,
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: const BoxDecoration(
          color: AppColors.headerActionBg,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: AppColors.primary400,
        ),
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final double totalAmount;
  final List<CategorySpendingEntity> categories;

  _DonutChartPainter({
    required this.totalAmount,
    required this.categories,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Ring thickness matching Figma 64_MY_ACTIVITY.png (~24px)
    final strokeWidth = 24.w;
    // Leave white rim margin matching Figma Image 2 (228x228 outer box)
    final radius = (size.width - strokeWidth - 28.w) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    if (totalAmount <= 0 || categories.isEmpty) {
      final neutralPaint = Paint()
        ..color = AppColors.gray200
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawCircle(center, radius, neutralPaint);
      return;
    }

    CategorySpendingEntity? findCat(String key) =>
        categories.cast<CategorySpendingEntity?>().firstWhere(
              (c) => c?.colorTokenKey == key,
              orElse: () => null,
            );

    final greenCat = findCat('chartGreen');
    final orangeCat = findCat('chartOrange');
    final redCat = findCat('chartRed');
    final blueCat = findCat('chartBlue');

    final double greenSweep = (greenCat != null && totalAmount > 0)
        ? (greenCat.amount / totalAmount) * 2 * math.pi
        : math.pi / 2;
    final double orangeSweep = (orangeCat != null && totalAmount > 0)
        ? (orangeCat.amount / totalAmount) * 2 * math.pi
        : math.pi / 4;
    final double redSweep = (redCat != null && totalAmount > 0)
        ? (redCat.amount / totalAmount) * 2 * math.pi
        : math.pi / 4;
    final double blueSweep = (blueCat != null && totalAmount > 0)
        ? (blueCat.amount / totalAmount) * 2 * math.pi
        : math.pi;

    // Sequential start angles starting from 9 o'clock (-pi rad)
    const greenStart = -math.pi;
    final orangeStart = greenStart + greenSweep;
    final redStart = orangeStart + orangeSweep;
    final blueStart = redStart + redSweep;

    // 1. Draw Green arc (Top-Left: 9 o'clock to 12 o'clock)
    final greenPaint = Paint()
      ..color = AppColors.chartGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true;
    canvas.drawArc(rect, greenStart, greenSweep, false, greenPaint);

    // 2. Draw Orange arc (Top-Right upper: 12 o'clock to ~1:30) with round cap overlapping Green
    final orangePaint = Paint()
      ..color = AppColors.chartOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
    canvas.drawArc(rect, orangeStart, orangeSweep, false, orangePaint);

    // 3. Draw Red arc (Top-Right lower: ~1:30 to 3 o'clock) with round cap overlapping Orange
    final redPaint = Paint()
      ..color = AppColors.chartRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
    canvas.drawArc(rect, redStart, redSweep, false, redPaint);

    // 4. Draw Blue arc (Bottom Half: 3 o'clock to 9 o'clock) with round caps overlapping Red and Green
    final bluePaint = Paint()
      ..color = AppColors.chartBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
    canvas.drawArc(rect, blueStart, blueSweep, false, bluePaint);
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.totalAmount != totalAmount ||
        oldDelegate.categories != categories;
  }
}
