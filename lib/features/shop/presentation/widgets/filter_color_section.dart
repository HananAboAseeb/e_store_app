import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class FilterColorItem {
  final String name;
  final Color color;

  const FilterColorItem({required this.name, required this.color});
}

class FilterColorSection extends StatelessWidget {
  final String? selectedColor;
  final ValueChanged<String?>? onColorSelected;

  const FilterColorSection({
    super.key,
    this.selectedColor,
    this.onColorSelected,
  });

  static const List<FilterColorItem> colors = [
    FilterColorItem(name: 'White', color: Color(0xFFFFFFFF)),
    FilterColorItem(name: 'Charcoal', color: Color(0xFF2C2C2E)),
    FilterColorItem(name: 'Blue', color: Color(0xFF004BFE)),
    FilterColorItem(name: 'Red', color: Color(0xFFFF3B30)),
    FilterColorItem(name: 'Teal', color: Color(0xFF00C7BE)),
    FilterColorItem(name: 'Yellow', color: Color(0xFFFFCC00)),
    FilterColorItem(name: 'Purple', color: Color(0xFFAF52DE)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: colors.map((item) {
            final isSelected =
                selectedColor?.toLowerCase() == item.name.toLowerCase();
            return GestureDetector(
              onTap: () => onColorSelected?.call(isSelected ? null : item.name),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: item.color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : (item.color == const Color(0xFFFFFFFF)
                                ? const Color(0xFFE5E5E5)
                                : Colors.transparent),
                        width: isSelected ? 2.5.w : 1.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: isSelected
                        ? Center(
                            child: Icon(
                              Icons.check,
                              size: 16.sp,
                              color: item.color == const Color(0xFFFFFFFF)
                                  ? AppColors.primary
                                  : Colors.white,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
