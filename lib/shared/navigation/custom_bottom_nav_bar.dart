import 'dart:ui';

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

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.40),
            border: Border(
              top: BorderSide(
                color: Colors.black.withOpacity(0.04),
                width: 0.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 16.r,
                offset: const Offset(0, -4),
              ),
            ],
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
        ),
      ),
    );
  }
}
