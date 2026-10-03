import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

/// Reusable circular close (X) button used across all modal sheets and dialogs.
/// Matching Figma Screen 58, 61: Size 36x36, Circle, Fill: #000000 10%, Icon: #000000 50%.
class ModalCloseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double? size;

  const ModalCloseButton({
    super.key,
    this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? 36.w;

    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: const BoxDecoration(
          color: AppColors.closeButtonBg,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.close_rounded,
          size: 18.sp,
          color: AppColors.closeButtonIcon,
        ),
      ),
    );
  }
}
