import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class FilterSizeSection extends StatelessWidget {
  final String sizeType;
  final String? selectedSize;
  final ValueChanged<String>? onSizeTypeChanged;
  final ValueChanged<String?>? onSizeSelected;

  const FilterSizeSection({
    super.key,
    required this.sizeType,
    this.selectedSize,
    this.onSizeTypeChanged,
    this.onSizeSelected,
  });

  static const List<String> clothesSizes = ['XS', 'S', 'M', 'L', 'XL', '2XL'];
  static const List<String> shoesSizes = [
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42'
  ];

  @override
  Widget build(BuildContext context) {
    final sizes = sizeType == 'Shoes' ? shoesSizes : clothesSizes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Segmented Switcher [ Clothes | Shoes ]
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Size',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSegmentPill('Clothes'),
                  _buildSegmentPill('Shoes'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Horizontal Size Strip
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(28.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: sizes.map((size) {
              final isSelected = selectedSize == size;
              return GestureDetector(
                onTap: () => onSizeSelected?.call(isSelected ? null : size),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: AppColors.primary, width: 2.w)
                        : null,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentPill(String type) {
    final isActive = sizeType == type;
    return GestureDetector(
      onTap: () => onSizeTypeChanged?.call(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
