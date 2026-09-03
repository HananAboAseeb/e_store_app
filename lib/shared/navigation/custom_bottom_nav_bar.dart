import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/extensions/layout_extensions.dart';
import 'nav_enum.dart';
import 'widgets/nav_item_widget.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = NavEnum.values;

    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12.r,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => NavItemWidget(
            tab: tabs[index],
            isSelected: currentIndex == index,
            onTap: () => onTap(index),
          ).expanded(),
        ),
      ),
    );
  }
}
