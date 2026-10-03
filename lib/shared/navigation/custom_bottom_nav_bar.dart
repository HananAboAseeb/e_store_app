import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/extensions/layout_extensions.dart';
import '../../core/theme/app_colors.dart';
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
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 0.8,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56.h,
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
        ),
      ),
    );
  }
}
