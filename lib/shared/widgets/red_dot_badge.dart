import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

/// Design System indicator badge dot.
///
/// Places an indicator dot at the top-right corner of the provided [child],
/// positioned within the padding box of the widget per Figma specifications.
class RedDotBadge extends StatelessWidget {
  final Widget child;
  final double? dotSize;
  final Offset? offset;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final bool showBadge;

  const RedDotBadge({
    super.key,
    required this.child,
    this.dotSize,
    this.offset,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showBadge) return child;

    final size = dotSize ?? 14.r;
    final topOffset = offset?.dy ?? -2.h;
    final rightOffset = offset?.dx ?? -2.w;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: topOffset,
          right: rightOffset,
          child: IgnorePointer(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color ?? AppColors.error,
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor ?? AppColors.white,
                  width: borderWidth ?? 2.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
