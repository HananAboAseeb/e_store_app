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
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: colors.map((item) {
            final isSelected =
                selectedColor?.toLowerCase() == item.name.toLowerCase();
            return GestureDetector(
              onTap: () => onColorSelected?.call(isSelected ? null : item.name),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 44.w,
                height: 44.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Outer Ring if selected
                    if (isSelected)
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF004BFE),
                            width: 2.2.w,
                          ),
                        ),
                      ),

                    // Color Circle
                    Container(
                      width: isSelected ? 32.w : 36.w,
                      height: isSelected ? 32.w : 36.w,
                      decoration: BoxDecoration(
                        color: item.color,
                        shape: BoxShape.circle,
                        border: item.color == const Color(0xFFFFFFFF)
                            ? Border.all(
                                color: const Color(0xFFE5E5EA),
                                width: 1.w,
                              )
                            : null,
                      ),
                    ),

                    // Top-Right Check Badge if selected
                    if (isSelected)
                      Positioned(
                        top: -1.h,
                        right: -1.w,
                        child: Container(
                          width: 18.w,
                          height: 18.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF004BFE),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              size: 11.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
