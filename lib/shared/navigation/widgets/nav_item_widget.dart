import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../nav_enum.dart';

class NavItemWidget extends StatelessWidget {
  final NavEnum tab;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final assetPath = isSelected ? tab.activeAsset : tab.inactiveAsset;

    final Widget iconWidget = Image.asset(
      assetPath,
      width: 25.w,
      height: 25.w,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          tab.inactiveAsset,
          width: 25.w,
          height: 25.w,
          fit: BoxFit.contain,
          color: isSelected ? const Color(0xFF004BFE) : null,
        );
      },
    );

    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: onTap,
      child: SizedBox(
        height: 56.h,
        child: Center(
          child: AnimatedScale(
            duration: _duration,
            scale: isSelected ? 1.05 : 1.0,
            child: iconWidget,
          ),
        ),
      ),
    );
  }
}
