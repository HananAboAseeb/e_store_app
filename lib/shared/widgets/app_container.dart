import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

/// Design System surface container widget.
///
/// Encapsulates consistent Figma surface styling:
/// - Default background: [AppColors.surfaceAnnouncement] (#F2F2F2)
/// - Default border radius: 20.r
/// - Optional border, padding, margin, fixed dimensions, and tap callback.
class AppContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final bool hasBorder;
  final Color? borderColor;
  final double? borderWidth;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final List<BoxShadow>? boxShadow;
  final Clip clipBehavior;
  final VoidCallback? onTap;

  const AppContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
    this.boxShadow,
    this.clipBehavior = Clip.none,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(20.r);
    final effectiveBg = backgroundColor ?? AppColors.surfaceAnnouncement;

    Widget container = Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      padding: padding,
      alignment: alignment,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: hasBorder
            ? Border.all(
                color: borderColor ?? AppColors.border,
                width: borderWidth ?? 1.w,
              )
            : null,
        boxShadow: boxShadow,
      ),
      child: child,
    );

    if (onTap != null) {
      container = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: container,
      );
    }

    return container;
  }
}
