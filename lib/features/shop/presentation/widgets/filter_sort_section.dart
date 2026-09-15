import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildSortChip(
            label: 'Popular',
            option: ShopSortOption.popular,
          ),
          SizedBox(width: 10.w),
          _buildSortChip(
            label: 'Newest',
            option: ShopSortOption.newest,
          ),
          SizedBox(width: 10.w),
          _buildSortChip(
            label: 'Price Hight to Low',
            option: ShopSortOption.priceHighToLow,
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip({
    required String label,
    required ShopSortOption option,
  }) {
    final isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () => onSortOptionSelected?.call(option),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDCE8FE) : const Color(0xFFEBECEF),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF004BFE)
                    : const Color(0xFF1A1A1A),
              ),
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Container(
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
            ],
          ],
        ),
      ),
    );
  }
}
