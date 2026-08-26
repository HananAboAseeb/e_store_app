import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../models/selection_item.dart';

class AuthSelectionList extends StatelessWidget {
  final List<SelectionItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final double? itemWidth;

  const AuthSelectionList({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(items.length, (index) {
        final item = items[index];
        final isSelected = index == selectedIndex;

        return Padding(
          padding: EdgeInsets.only(bottom: index == items.length - 1 ? 0 : 12.h),
          child: GestureDetector(
            onTap: () => onSelected(index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: (itemWidth ?? 215).w,
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.title,
                    style: AppTypography.body.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColors.primary400 : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? AppColors.primary400 : const Color(0xFFC7C7CC),
                        width: 2.w,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: isSelected
                        ? Icon(
                            Icons.check_rounded,
                            size: 16.sp,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
