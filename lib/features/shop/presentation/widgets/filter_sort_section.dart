import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/filter_criteria_entity.dart';

class FilterSortSection extends StatelessWidget {
  final ShopSortOption selectedOption;
  final ValueChanged<ShopSortOption>? onSortOptionSelected;

  const FilterSortSection({
    super.key,
    required this.selectedOption,
    this.onSortOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort by',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildSortChip(
                label: 'Popular',
                option: ShopSortOption.popular,
              ),
              SizedBox(width: 8.w),
              _buildSortChip(
                label: 'Newest',
                option: ShopSortOption.newest,
              ),
              SizedBox(width: 8.w),
              _buildSortChip(
                label: 'Price High to Low',
                option: ShopSortOption.priceHighToLow,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSortChip({
    required String label,
    required ShopSortOption option,
  }) {
    final isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () => onSortOptionSelected?.call(option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEBF1FF) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 1.5.w)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Container(
                width: 16.w,
                height: 16.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
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
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
