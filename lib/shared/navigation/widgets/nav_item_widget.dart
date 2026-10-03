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
    const activeColor = Color(0xFF004BFE);
    const inactiveColor =
        Color(0xFF1E293B); // Dark crisp charcoal matching Figma

    final Widget iconWidget = isSelected
        ? Icon(
            tab.activeIcon,
            size: 26.sp,
            color: activeColor,
          )
        : (tab.assetPath != null
            ? ImageIcon(
                AssetImage(tab.assetPath!),
                size: 24.sp,
                color: inactiveColor,
              )
            : Icon(
                tab.inactiveIcon,
                size: 26.sp,
                color: inactiveColor,
              ));

    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: onTap,
      child: SizedBox(
        height: 60.h,
        child: AnimatedScale(
          duration: _duration,
          scale: isSelected ? 1.15 : 1.0,
          child: iconWidget,
        ),
      ),
    );
  }
}
