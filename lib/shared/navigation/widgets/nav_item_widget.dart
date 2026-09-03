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
    const inactiveColor = Color(0xFF8E8E93);

    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: onTap,
      child: SizedBox(
        height: 60.h,
        child: AnimatedScale(
          duration: _duration,
          scale: isSelected ? 1.15 : 1.0,
          child: Icon(
            isSelected ? tab.activeIcon : tab.inactiveIcon,
            size: 26.sp,
            color: isSelected ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}
